import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/item.dart';
import 'package:starter_architecture_flutter_firebase/routing/cupertino_tab_view_router.dart';
import 'package:starter_architecture_flutter_firebase/app/top_level_providers.dart';
import 'package:flutter/material.dart';

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

  static Future<void> show(BuildContext context, Item item) async {
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
          title: ItemEntriesAppBarTitle(item: item)
      ),
      body: _buildItemDetails(item, context),

    );
  }

  Widget _buildItemDetails(Item item, BuildContext context) {
    // align for sold item
    Align align;
    //use case.
    if (item.bought){ 
          align =  Align(
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
              onPressed: null,
              child: const Text('Sold', style: TextStyle(fontSize: 20)),
              color: Colors.grey,
              textColor: Colors.white,
              elevation: 5
          ),
        );
    }
    else{
          align =  Align(
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
              onPressed: () => null,
              child: const Text('on listing', style: TextStyle(fontSize: 20)),
              color: Colors.grey,
              textColor: Colors.white,
              elevation: 5
          ),
        );
    }
    return Column(
      children: [
        Text(
          'Name: ${item.name}',
          style: const TextStyle(color: Colors.black),
        ),
        Text(
          item.price.toString(),
          style: const TextStyle(color: Colors.black),
        ),
        Text(
          item.description,
          style: const TextStyle(color: Colors.black),
        ),
        Text(
          item.category,
          style: const TextStyle(color: Colors.black),
        ),
        align, 
      ],
    );
  }
  // Widget _buyAction(BuildContext context) {
  //
  // }
}


