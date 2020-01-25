import 'dart:ui';

import 'package:meta/meta.dart';

class Job {
  Job({@required this.id, @required this.name, @required this.ratePerHour});
  final String id;
  final String name;
  final int ratePerHour;

  // TODO(3) serialize and deserialize json-type objects inside strongly-typed model classes
  // Unless you're using code generation tools to automate this,
  // you are likely to write this kind of code by hand.
  // You may sleep better at night if you have some tests
  // to check that your serialization code works correctly under various edge cases.
  factory Job.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    if (name == null) {
      return null;
    }
    final int ratePerHour = data['ratePerHour'];
    return Job(id: documentId, name: name, ratePerHour: ratePerHour);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ratePerHour': ratePerHour,
    };
  }

  // If you want to compare your model classes like this, you need to implement your own hashCode and == operators.
  @override
  int get hashCode => hashValues(id, name, ratePerHour);

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Job otherJob = other;
    return id == otherJob.id &&
        name == otherJob.name &&
        ratePerHour == otherJob.ratePerHour;
  }

  // also useful to implement this: print meaningful information to console.
  @override
  String toString() => 'id: $id, name: $name, ratePerHour: $ratePerHour';

  // if you only have a handful of simple model classes,
  // you can implement all this by hand.
  // But if you have a lot of models,
  // you should take a look at code generation instead.
}
