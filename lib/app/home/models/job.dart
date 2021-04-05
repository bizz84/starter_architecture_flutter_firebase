import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Job extends Equatable {
  const Job({required this.id, required this.name, required this.price, required this.description});
  final String id;
  final String name;
  final int price;
  final String description;

  @override
  List<Object> get props => [id, name, price, description];

  @override
  bool get stringify => true;

  factory Job.fromMap(Map<String, dynamic>? data, String documentId) {
    if (data == null) {
      throw StateError('missing data for jobId: $documentId');
    }
    final name = data['name'] as String?;
    if (name == null) {
      throw StateError('missing name for jobId: $documentId');
    }
    final price = data['price'] as int;
    final description = data['description'] as String?;
    if (description == null) {
      throw StateError('missing description for jobId: $documentId');
    }
    return Job(id: documentId, name: name, price: price, description: description);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'description': description,
    };
  }
}
