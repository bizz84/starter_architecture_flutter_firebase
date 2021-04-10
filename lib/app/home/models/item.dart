import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Item extends Equatable {
  const Item({required this.id, required this.name, required this.price, required this.description, required this.category, required this.bought});
  final String id;
  final String name;
  final int price;
  final String description;
  final String category; 
  final bool bought; // default Falss

  @override
  List<Object> get props => [id, name, price, description, category, bought];

  @override
  bool get stringify => true;

  factory Item.fromMap(Map<String, dynamic>? data, String documentId) {
    if (data == null) {
      throw StateError('missing data for product Id: $documentId');
    }
    final name = data['name'] as String?;
    if (name == null) {
      throw StateError('missing name for product Id: $documentId');
    }
    final price = data['price'] as int;
    final description = data['description'] as String?;
    if (description == null) {
      throw StateError('missing description for product Id: $documentId');
    }
    final category = data['category'] as String?; 
    if (category == null){
      throw StateError('missing category for product Id: $documentId');
    } 
    final bought = data['bought'] as bool; 
    return Item(id: documentId, name: name, price: price, description: description, category: category, bought: bought);
  }

  //TODO: fromMap from the backend
  factory Item.fromMapItem(Map<String, dynamic>? data, String documentId) {
    if (data == null) {
      throw StateError('missing data for product Id: $documentId');
    }
    final name = data['name'] as String?;
    if (name == null) {
      throw StateError('missing name for product Id: $documentId');
    }
    final price = data['price'] as int;
    final description = data['description'] as String?;
    if (description == null) {
      throw StateError('missing description for product Id: $documentId');
    }
    final category = data['category'] as String?;
    if (category == null){
      throw StateError('missing category for product Id: $documentId');
    }
    final bought = data['bought'] as bool;
    return Item(id: documentId, name: name, price: price, description: description, category: category, bought: bought);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'category': category, 
      'bought': bought, 
    };
  }
  Map<String, dynamic> toMapItem(String uid) {
    return {
      'name': name,
      'price': price,
      'description': description,
      'category': category,
      'bought': bought,
      'buyerUUID': 'Not Sold',
      'sellerUUID': uid
    };
  }

}
