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

// delete after testing
import 'book.dart';
import 'get_books.dart';

String? _category = 'phones';

//db stream of _category
final itemsStreamProvider = StreamProvider.autoDispose<List<Item>>((ref) {
  final database = ref.watch(databaseProvider);
  return database.itemsSoldStream(_category);
});

class BrowsePage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  String? _category;
  bool? _bought;

  List<Book> books = GetBooks.books;
  List<Item> items = [];
  //get items list
//   Future<List<String>> items () async  {
//   return await itemsStreamProvider.first;
// }

  Future<void> show(BuildContext context, String? category) async {
    _category = category;
    await Navigator.of(context).pushNamed(
      CupertinoTabViewRoutes.searchResultPage,
    );
  }

  //put stream into array => list out in build
  // final itemsAsyncValue = watch(itemsStreamProvider);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final itemsAsyncValue = watch(itemsStreamProvider);

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
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _searchBar(),
          _header("Recent Listings"),
          _buildCarousel("recent"),
          _header("Phones"),
          _buildCarousel("phones"),
          _header("Laptops"),
          _buildCarousel("laptops"),
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

  Widget _buildCarousel(String category) {
    _category = category;

    return Container(
      height: 200,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.45),
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        //itemCount: books.length,

        itemBuilder: (BuildContext context, int index) {
          Book book = books[index];
          // Item items = items[index];
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
                      // '${itemsAsyncValue.data.name}',
                      '${book.name}',
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
                      '${book.author}',
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
