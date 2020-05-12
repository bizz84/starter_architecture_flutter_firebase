import 'package:flutter_test/flutter_test.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/job.dart';

void main() {
  group('fromMap', () {
    test('null data', () {
      final job = Job.fromMap(null, 'abc');
      expect(job, null);
    });
    test('job with all properties', () {
      final job = Job.fromMap(const {
        'name': 'Blogging',
        'ratePerHour': 10,
      }, 'abc');
      expect(job, const Job(name: 'Blogging', ratePerHour: 10, id: 'abc'));
    });

    test('missing name', () {
      final job = Job.fromMap(const {
        'ratePerHour': 10,
      }, 'abc');
      expect(job, null);
    });
  });

  group('toMap', () {
    test('valid name, ratePerHour', () {
      const job = Job(name: 'Blogging', ratePerHour: 10, id: 'abc');
      expect(job.toMap(), {
        'name': 'Blogging',
        'ratePerHour': 10,
      });
    });
  });
}
