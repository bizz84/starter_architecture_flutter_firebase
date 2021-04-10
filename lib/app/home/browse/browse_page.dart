import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/item.dart';
import 'package:alert_dialogs/alert_dialogs.dart';
import 'package:starter_architecture_flutter_firebase/app/top_level_providers.dart';
import 'package:starter_architecture_flutter_firebase/routing/app_router.dart';
import 'package:starter_architecture_flutter_firebase/firebase/firestore_database.dart';
import 'package:starter_architecture_flutter_firebase/constants/strings.dart';
import 'package:starter_architecture_flutter_firebase/app/home/browse/search_page_result.dart';
import 'package:pedantic/pedantic.dart';
import 'package:flutter/foundation.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({Key? key, this.item}) : super(key: key);
  final Item? item;

  static Future<void> show(BuildContext context, {Item? item}) async {
    await Navigator.of(context, rootNavigator: true).pushNamed(
      AppRoutes.editItemPage,
      arguments: item,
    );
  }

  @override
  _BrowsePageState createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _category;
  bool? _bought;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _name = widget.item?.name;
      _category = widget.item?.category;
      _bought = widget.item?.bought;
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

  Future<void> _search() async {
    if (_validateAndSaveForm()) {
      try {
        final database = context.read<FirestoreDatabase>(databaseProvider);
        await SearchPageResult.show(context, _category);

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
        title: Text(widget.item == null ? 'New Product' : 'Edit Product'),
        actions: <Widget>[
          FlatButton(
            child: const Text(
              'Search',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () => _search(),
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


  String _currentSelectedValue = 'phones';
  List<Widget> _buildFormChildren() {
    _bought = false;
    return [
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
                items: Strings.categories.map((String value) {
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
      ),
    ];
  }
}
