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

class BrowsePage extends ConsumerWidget {

  final _formKey = GlobalKey<FormState>();
  String? _category;
  bool? _bought;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('Search'),
        actions: <Widget>[
          FlatButton(
            child: const Text(
              'Search',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () => SearchPageResult.show(context, _category),
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
    debugPrint("_currentSelectedValue");
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
                    _currentSelectedValue = newValue!;
                    state.didChange(newValue);
                    _category = _currentSelectedValue;
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
        onSaved: (value) {
          _category = _currentSelectedValue;
        },
      ),
    ];
  }
}
