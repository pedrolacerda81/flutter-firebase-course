import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/app/home/models/job.dart';

void main() {
  group('Job - from Map', () {
    test('Null Data', () {
      final Job job = Job.fromMap(null, 'abc');
      expect(job, null);
    });

    test('with all properties', () {
      final Job job = Job.fromMap({
        'name': 'Blogging',
        'ratePerHour': 10,
      }, 'abc');
//      expect(job.name, 'Blogging');
//      expect(job.ratePerHour, 10);
//      expect(job.id, 'abc');
      expect(job, Job(name: 'Blogging', ratePerHour: 10, id: 'abc'));
    });

    test('missing properties', () {
      final Job job = Job.fromMap({
        'name': 'Blogging',
      }, 'abc');
      expect(job, null);
    });
  });

  group('Job - toMap', () {
    test('valid name and ratePerHour', () {
      final Job job = Job(name: 'Blogging', ratePerHour: 10, id: 'abc');
      expect(job.toMap(), {
        'name': 'Blogging',
        'ratePerHour': 10,
      });
    });
  });
}
