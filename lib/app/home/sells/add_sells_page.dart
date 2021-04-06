import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/job.dart';
import 'package:alert_dialogs/alert_dialogs.dart';
import 'package:starter_architecture_flutter_firebase/app/top_level_providers.dart';
import 'package:starter_architecture_flutter_firebase/routing/app_router.dart';
import 'package:starter_architecture_flutter_firebase/services/firestore_database.dart';
import 'package:pedantic/pedantic.dart';

class EditJobPage extends StatefulWidget {
  const EditJobPage({Key? key, this.job}) : super(key: key);
  final Job? job;

  static Future<void> show(BuildContext context, {Job? job}) async {
    await Navigator.of(context, rootNavigator: true).pushNamed(
      AppRoutes.editJobPage,
      arguments: job,
    );
  }

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  int? _price;
  String? _description;
  String? _category; 
  @override
  void initState() {
    super.initState();
    if (widget.job != null) {
      _name = widget.job?.name;
      _price = widget.job?.price;
      _description = widget.job?.description;
      _category = widget.job?.category; 
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final database = context.read<FirestoreDatabase>(databaseProvider);
        final jobs = await database.jobsStream().first;
        final allLowerCaseNames =
            jobs.map((job) => job.name.toLowerCase()).toList();
        if (widget.job != null) {
          allLowerCaseNames.remove(widget.job!.name.toLowerCase());
        }
        if (allLowerCaseNames.contains(_name?.toLowerCase())) {
          unawaited(showAlertDialog(
            context: context,
            title: 'Name already used',
            content: 'Please choose a different product name',
            defaultActionText: 'OK',
          ));
        } else {
          final id = widget.job?.id ?? documentIdFromCurrentDate();
          final job =
              Job(id: id, name: _name ?? '', price: _price ?? 0, description: _description ?? '', category: _category ?? 'phone');
          await database.setJob(job);
          Navigator.of(context).pop();
        }
      } catch (e) {
        unawaited(showExceptionAlertDialog(
          context: context,
          title: 'Operation failed',
          exception: e,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.job == null ? 'New Product' : 'Edit Product'),
        actions: <Widget>[
          FlatButton(
            child: const Text(
              'Save',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () => _submit(),
          ),
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }
  var _categories = [
    'phones',
    'laptop',
    'others'
  ];
  String _currentSelectedValue ='phones'; 
  List<Widget> _buildFormChildren() {
    
    return [
      TextFormField(
        decoration: const InputDecoration(labelText: 'Product name'),
        keyboardAppearance: Brightness.light,
        initialValue: _name,
        validator: (value) =>
            (value ?? '').isNotEmpty ? null : 'Name can\'t be empty',
        onSaved: (value) => _name = value,
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Price'),
        keyboardAppearance: Brightness.light,
        initialValue: _price != null ? '$_price' : null,
        keyboardType: const TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _price = int.tryParse(value ?? '') ?? 0,
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Description'),
        keyboardAppearance: Brightness.light,
        initialValue:  _description,
        onSaved: (value) => _description = value,
      ),
     FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(labelText: 'Categories'),
              isEmpty: _currentSelectedValue == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _currentSelectedValue,
                  isDense: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      _currentSelectedValue = newValue!;
                      state.didChange(newValue);
                    });
                  },
                  items: _categories.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
          onSaved: (value) => _category = value, 
        )
    ];
  }
}
