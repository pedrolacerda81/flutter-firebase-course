import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_bloc.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_model.dart';
import '../../mocks/mocks.dart';

void main() {
  MockAuth mockAuth;
  EmailSignInBloc bloc;

  setUp(() {
    mockAuth = MockAuth();
    bloc = EmailSignInBloc(auth: mockAuth);
  });

  tearDown(() {
    bloc.dispose();
  });

  test(
      'WHEN email is updated'
      'AND password is updated'
      'AND submit is called'
      'THEN modelStream emit the correct events', () async {
    when(mockAuth.signInWithEmailAndPassword(any, any))
        .thenThrow(PlatformException(code: 'ERROR'));

    final sampleEmail = 'email@email.com';
    final samplePassword = 'password';

    expect(
      bloc.modelStream,
      emitsInOrder([
        EmailSignInModel(),
        EmailSignInModel(email: sampleEmail),
        EmailSignInModel(email: sampleEmail, password: samplePassword),
        EmailSignInModel(
            email: sampleEmail,
            password: samplePassword,
            isLoading: true,
            submitted: true),
        EmailSignInModel(
            email: sampleEmail,
            password: samplePassword,
            isLoading: false,
            submitted: true),
      ]),
    );

    bloc.updateEmail(sampleEmail);
    bloc.updatePassword(samplePassword);

    try {
      await bloc.submit();
    } catch (e) {}
  });
}
