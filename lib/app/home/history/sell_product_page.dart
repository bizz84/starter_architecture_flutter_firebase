import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/item.dart';
import 'package:starter_architecture_flutter_firebase/routing/cupertino_tab_view_router.dart';
import 'package:starter_architecture_flutter_firebase/app/top_level_providers.dart';
import 'package:flutter/material.dart';
import 'package:starter_architecture_flutter_firebase/firebase/firestore_database.dart';

String? _origin;

final itemStreamProvider =
    StreamProvider.autoDispose.family<Item, String>((ref, itemId) {
  final database = ref.watch(databaseProvider);
  return database.itemStream(itemId: itemId);
});

class ItemEntriesAppBarTitle extends ConsumerWidget {
  const ItemEntriesAppBarTitle({required this.item});
  final Item item;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final itemAsyncValue = watch(itemStreamProvider(item.id));
    return itemAsyncValue.when(
      data: (item) => Text(item.name),
      loading: () => Container(),
      error: (_, __) => Container(),
    );
  }
}

class SellProductPage extends StatelessWidget {
  const SellProductPage({required this.item});

  final Item item;

  static Future<void> show(
      BuildContext context, Item item, String origin) async {
    _origin = origin;
    await Navigator.of(context).pushNamed(
      CupertinoTabViewRoutes.sellProductPage,
      arguments: item,
    );
  }

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = context.read(firebaseAuthProvider);
    final user = firebaseAuth.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: ItemEntriesAppBarTitle(item: item),
        centerTitle: true,
      ),
      body: _buildItemDetails(item, context),
    );
  }

  Widget _buildItemDetails(Item item, BuildContext context) {
    // align for sold item
    Align align;
    String buttonText;
    String price = item.price.toString();
    RaisedButton button = RaisedButton(
        onPressed: () => null,
        child: Text('On Listing', style: TextStyle(fontSize: 20)),
        color: Colors.grey,
        textColor: Colors.white,
        elevation: 5);

    Future<void> createAlertDialog(BuildContext context) async {
      //TODO: edit database here
      return showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: Text("Email to the seller sent"),
                content: Text(
                    "We sent an email to the seller you are buying a product from"),
                actions: <Widget>[
                  MaterialButton(
                      child: const Text('ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ]);
          });
    }

// Template
    final firebaseAuth = context.read(firebaseAuthProvider);
    final user = firebaseAuth.currentUser!;

    if (_origin == 'history') {
      //TODO: get Seller UUID and current UUID
      if (item.sellerUUID == user.uid) {
        if (!item.bought) {
          button = RaisedButton(
              onPressed: () => null,
              child: Text('On Listing', style: TextStyle(fontSize: 20)),
              color: Colors.grey,
              textColor: Colors.white,
              elevation: 5);
        } else {
          button = RaisedButton(
              onPressed: () => null,
              child: Text('Sold', style: TextStyle(fontSize: 20)),
              color: Colors.grey,
              textColor: Colors.white,
              elevation: 5);
        }
      } else {
        if (item.bought) {
          button = RaisedButton(
              onPressed: () => null,
              child: Text('Bought', style: TextStyle(fontSize: 20)),
              color: Colors.grey,
              textColor: Colors.white,
              elevation: 5);
        }
      }
    } else {
      if (item.sellerUUID == user.uid) {
        if (item.bought == false) {
          button = RaisedButton(
              onPressed: () => createAlertDialog(context),
              child: Text('Buy', style: TextStyle(fontSize: 20)),
              color: Colors.grey,
              textColor: Colors.white,
              elevation: 5);
        } else {
          if (item.bought == false) {
            button = RaisedButton(
                onPressed: () => null,
                child: Text('Sold', style: TextStyle(fontSize: 20)),
                color: Colors.grey,
                textColor: Colors.white,
                elevation: 5);
          }
        }
      }

      // if (item.bought) {
      //   buttonText = 'Sold';
      //   // align = Align(
      //   //   alignment: Alignment.bottomCenter,
      //   //   child: RaisedButton(
      //   //       onPressed: null,
      //   //       child: const Text('Sold', style: TextStyle(fontSize: 20)),
      //   //       color: Colors.grey,
      //   //       textColor: Colors.white,
      //   //       elevation: 5),
      //   // );
      // } else {
      //   buttonText = 'On Listing';
      //   // align = Align(
      //   //   alignment: Alignment.bottomRight,
      //   //   child: RaisedButton(
      //   //       onPressed: () => null,
      //   //       child: const Text('on listing', style: TextStyle(fontSize: 20)),
      //   //       color: Colors.grey,
      //   //       textColor: Colors.white,
      //   //       elevation: 5),
      //   // );

    }

    return Column(
      children: [
        // Image.asset("assets/mac.jpeg"),
        Container(
          width: 300,
          height: 300,
          child: Image.network(
              'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mbp13touch-space-select-202005?wid=892&hei=820&&qlt=80&.v=1587460552755'),
        ),
        Container(
            child: Text(
              item.description,
              style: const TextStyle(height: 1.5, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
            padding: EdgeInsets.all(16)),
        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price: \$$price',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 28),
                      ),
                      button,
                      // ButtonTheme(
                      //   minWidth: 200.0,
                      //   height: 50.0,
                      //   child: RaisedButton(
                      //       onPressed: () => null,
                      //       child: Text(buttonText,
                      //           style: TextStyle(fontSize: 20)),
                      //       color: Colors.grey,
                      //       textColor: Colors.white,
                      //       elevation: 5),
                      // ),
                    ],
                  )),
            ]),
      ],
    );
  }
  // Widget _buyAction(BuildContext context) {
  //
  // }
}
