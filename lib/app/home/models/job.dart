import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Job extends Equatable {
  const Job({required this.id, required this.name, required this.price, required this.description, required this.category});
  final String id;
  final String name;
  final int price;
  final String description;
  final String category; 

  @override
  List<Object> get props => [id, name, price, description, category];

  @override
  bool get stringify => true;

  factory Job.fromMap(Map<String, dynamic>? data, String documentId) {
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

    return Job(id: documentId, name: name, price: price, description: description, category: category);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'category': category, 
    };
  }
}
