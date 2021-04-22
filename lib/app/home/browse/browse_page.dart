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
import 'package:starter_architecture_flutter_firebase/app/home/history/sell_product_page.dart';
import 'package:flutter/cupertino.dart';

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

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final itemsAsyncValuePhone = watch(itemsStreamProviderPhone);
    final itemsAsyncValueLaptop = watch(itemsStreamProviderLaptop);
    final itemsAsyncValueOther = watch(itemsStreamProviderOther);

    final List<Item>? items = itemsAsyncValuePhone.data?.value;
    final List<Item>? laptops = itemsAsyncValueLaptop.data?.value;
    final List<Item>? others = itemsAsyncValueOther.data?.value;
    List<Item>? itemsBuyable = [];
    List<Item>? laptopsBuyable = [];
    List<Item>? othersBuyable = [];

    for (int i = 0; i < items!.length; i++) {
      if (!items[i].bought) {
        itemsBuyable.add(items[i]);
      }
    }
    for (int i = 0; i < laptops!.length; i++) {
      if (!laptops[i].bought) {
        laptopsBuyable.add(laptops[i]);
      }
    }
    for (int i = 0; i < others!.length; i++) {
      if (!others[i].bought) {
        othersBuyable.add(others[i]);
      }
    }

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
      body: _buildContents(itemsBuyable, laptopsBuyable, othersBuyable),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents(List<Item>? itemsBuyable, List<Item>? laptopsBuyable,
      List<Item>? othersBuyable) {
    List<Item> temp = [];
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _searchBar(),
          // _header("Recent Listings"),
          // _buildCarousel("Recent Listings", itemsBuyable),
          _header("Phones"),
          _buildCarousel("phones", itemsBuyable,
              'https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-12-og-202010?wid=1200&hei=630&fmt=jpeg&qlt=95&.v=1601435256000'),
          _header("Laptops"),
          _buildCarousel("laptops", laptopsBuyable,
              'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp13touch-space-select-202005?wid=892&hei=820&&qlt=80&.v=1587460552755%27'),
          _header("Others"),
          _buildCarousel("others", othersBuyable,
              'https://firebasestorage.googleapis.com/v0/b/mobilecomp-5c1d5.appspot.com/o/others.png?alt=media&token=aa451243-584c-48a7-bca9-b5ba2a0ed1f1'),
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

  Widget _buildCarousel(String category, List<Item>? items, String imageurl) {
    _category = category;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 200,
        child: PageView.builder(
          controller: PageController(viewportFraction: 0.35),
          scrollDirection: Axis.horizontal,
          itemCount: items!.length,
          itemBuilder: (BuildContext context, int index) {
            final Item item = items[index];
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                child: Column(
                  children: [
                    GestureDetector(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 105,
                          width: 300,
                          child: Image.network(imageurl),
                        ),
                        // child: Image(
                        //   height: 200,
                        //   width: 180,
                        //   image: AssetImage(book.image),
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      onTap: () =>
                          SellProductPage.show(context, item, 'history'),
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
                        '\$ ${item.price}',
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
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
