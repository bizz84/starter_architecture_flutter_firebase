import 'package:flutter_test/flutter_test.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/job.dart';

void main() {
  group('fromMap', () {
    test('null data', () {
      expect(
          () => Job.fromMap(null, 'abc'), throwsA(isInstanceOf<StateError>()));
    });
    test('job with all properties', () {
      final job = Job.fromMap(const {
        'name': 'Blogging',
        'ratePerHour': 10,
      }, 'abc');
      expect(job, const Job(name: 'Blogging', ratePerHour: 10, id: 'abc'));
    });

    test('missing name', () {
      expect(
          () => Job.fromMap(const {
                'ratePerHour': 10,
              }, 'abc'),
          throwsA(isInstanceOf<StateError>()));
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

  group('equality', () {
    test('different properties, equality returns false', () {
      const job1 = Job(name: 'Blogging', ratePerHour: 10, id: 'abc');
      const job2 = Job(name: 'Blogging', ratePerHour: 5, id: 'abc');
      expect(job1 == job2, false);
    });
    test('same properties, equality returns true', () {
      const job1 = Job(name: 'Blogging', ratePerHour: 10, id: 'abc');
      const job2 = Job(name: 'Blogging', ratePerHour: 10, id: 'abc');
      expect(job1 == job2, true);
    });
  });
}
