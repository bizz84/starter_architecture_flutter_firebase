import 'dart:async';

import 'package:firestore_service/firestore_service.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/entry.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/item.dart';
import 'package:starter_architecture_flutter_firebase/firebase/firestore_path.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase {
  FirestoreDatabase({required this.uid});
  final String uid;

  final _service = FirestoreService.instance;

  Future<void> setItem(Item item) => _service.setData(
        path: FirestorePath.item(uid, item.id),
        data: item.toMap(),
  );

  Future<void> setSold(Item item) => _service.setData(
    path: FirestorePath.categories(item.category, item.id),
    data: item.toMapItem(uid)
  );

  Stream<List<Item>> itemsSoldStream(String? category) => _service.collectionStream(
    path: FirestorePath.searchCategory(category),
    builder: (data, documentId) => Item.fromMap(data, documentId),
  );

  Stream<List<Item>> historyStream() =>_service.collectionStream(
    path: FirestorePath.history(),
    builder: (data, documentId) => Item.fromMap(data, documentId),

  );

  // Future<void> deleteItem(Item item) async {
  //   // delete where entry.itemId == item.itemId
  //   final allEntries = await entriesStream(item: item).first;
  //   for (final entry in allEntries) {
  //     if (entry.itemId == item.id) {
  //       await deleteEntry(entry);
  //     }
  //   }
  //   // delete item
  //     await _service.deleteData(path: FirestorePath.item(uid, item.id));
  // }

  Stream<Item> itemStream({required String itemId}) => _service.documentStream(
      path: FirestorePath.item(uid, itemId),
      builder: (data, documentId) => Item.fromMap(data, documentId),
  );

  Stream<List<Item>> itemsStream() => _service.collectionStream(
        path: FirestorePath.items(uid),
        builder: (data, documentId) => Item.fromMap(data, documentId),
      );

  Future<void> setEntry(Entry entry) => _service.setData(
        path: FirestorePath.entry(uid, entry.id),
        data: entry.toMap(),
      );

  Future<void> deleteEntry(Entry entry) =>
      _service.deleteData(path: FirestorePath.entry(uid, entry.id));

  Stream<List<Entry>> entriesStream({Item? item}) =>
      _service.collectionStream<Entry>(
        path: FirestorePath.entries(uid),
        queryBuilder: item != null
            ? (query) => query.where('itemId', isEqualTo: item.id)
            : null,
        builder: (data, documentID) => Entry.fromMap(data, documentID),
        sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
      );
}
