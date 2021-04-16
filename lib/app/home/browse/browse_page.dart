import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:starter_architecture_flutter_firebase/routing/cupertino_tab_view_router.dart';

import 'package:flutter/cupertino.dart';

// String? _category = 'phones';

//db stream of _category
final itemsStreamProviderPhone = StreamProvider.autoDispose<List<Item>>((ref) {
  final database = ref.watch(databaseProvider);
  return database.itemsSoldStream('phones');
});
final itemsStreamProviderLaptop = StreamProvider.autoDispose<List<Item>>((ref) {
  final database = ref.watch(databaseProvider);
  return database.itemsSoldStream('laptop');
});
final itemsStreamProviderOther = StreamProvider.autoDispose<List<Item>>((ref) {
  final database = ref.watch(databaseProvider);
  return database.itemsSoldStream('others');
});

class BrowsePage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  String? _category;
  bool? _bought;

  Future<void> show(BuildContext context, String? category) async {
    _category = category;
    await Navigator.of(context).pushNamed(
      CupertinoTabViewRoutes.searchResultPage,
    );
  }

  // List<Book> books = GetBooks.books;
  List<Item> items = [];

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final itemsAsyncValuePhone = watch(itemsStreamProviderPhone);
    final itemsAsyncValueLaptop = watch(itemsStreamProviderLaptop);
    final itemsAsyncValueOther = watch(itemsStreamProviderOther);

    final List<Item>? items = itemsAsyncValuePhone.data?.value;
    final List<Item>? laptops = itemsAsyncValueLaptop.data?.value;
    final List<Item>? others = itemsAsyncValueOther.data?.value;
    // final List<Item>? books = itemsAsyncValue.data?.value;

    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('Marketplace'),
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
      body: _buildContents(items, laptops, others),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents(
      List<Item>? items, List<Item>? laptops, List<Item>? others) {
    List<Item> temp = [];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _searchBar(),
          _header("Recent Listings"),
          _buildCarousel("Recent Listings", items),
          _header("Phones"),
          _buildCarousel("phones", items),
          _header("Laptops"),
          _buildCarousel("laptops", laptops),
          _header("Others"),
          _buildCarousel("others", others),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Container(
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

  Widget _header(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCarousel(String category, List<Item>? items) {
    _category = category;

    return Container(
      height: 200,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.45),
        scrollDirection: Axis.horizontal,
        itemCount: items!.length,
        //itemCount: books.length,

        itemBuilder: (BuildContext context, int index) {
          // Item item = items![index];
          Item item = items[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 100,
                      width: 300,
                      color: Colors.red,
                    ),
                    // child: Image(
                    //   height: 200,
                    //   width: 180,
                    //   image: AssetImage(book.image),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '${item.name}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      // '${itemsAsyncValue.data.name}',
                      '${item.price}',
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          );
        },
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
