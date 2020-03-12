import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker_flutter_course/app/home/job_entries/format.dart';

void main() {
  group('Hours', () {
    test('positive', () {
      expect(Format.hours(10), '10h');
    });

    test('zero', () {
      expect(Format.hours(0), '0h');
    });

    test('negative', () {
      expect(Format.hours(-10), '0h');
    });

    test('decimal', () {
      expect(Format.hours(10.5), '10.5h');
    });
  });

  group('date - GB Locale', () {
    setUp(() async {
      Intl.defaultLocale = 'en_GB';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('2020-02-28', () {
      expect(Format.date(DateTime(2020, 2, 28)), '28 Feb 2020');
    });
    test('2020-03-11', () {
      expect(Format.date(DateTime(2020, 3, 11)), '11 Mar 2020');
    });
  });

  group('date - US Locale', () {
    setUp(() async {
      Intl.defaultLocale = 'en_US';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('2020-02-28', () {
      expect(Format.date(DateTime(2020, 2, 28)), 'Feb 28, 2020');
    });
  });

  group('date - pt_BR Locale', () {
    setUp(() async {
      Intl.defaultLocale = 'pt_BR';
      await initializeDateFormatting(Intl.defaultLocale);
    });
    test('2020-02-28', () {
      expect(Format.date(DateTime(2020, 2, 28)), '28 de fev de 2020');
    });
  });
}