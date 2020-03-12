import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/app/sign_in/validators.dart';

void main() {
  test('Validator non empty String', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid('test'), true);
  });
}