import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_change_model.dart';
import '../../mocks/mocks.dart';

void main() {
  MockAuth mockAuth;
  EmailSignInChangeModel model;

  setUp(() {
    mockAuth = MockAuth();
    model = EmailSignInChangeModel(auth: mockAuth);
  });

  test('Update email', (){
    var didNotifyListeners = false;
    model.addListener(() => didNotifyListeners = true);

    const sampleEmail = 'email@email.com';
    model.updateEmail(sampleEmail);

    expect(model.email, sampleEmail);
    expect(didNotifyListeners, true);

  });
}