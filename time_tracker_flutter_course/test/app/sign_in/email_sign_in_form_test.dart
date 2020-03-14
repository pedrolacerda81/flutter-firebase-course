import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_form_stateful.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class MockAuth extends Mock implements AuthBase {}

void main() {
  MockAuth mockAuth;
  setUp(() {
    mockAuth = MockAuth();
  });

  Future<void> pumpEmailSignInForm(WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(
      Provider<AuthBase>(
        create: (_) => mockAuth,
        child: MaterialApp(
          home: Scaffold(
            body: EmailSignInFormStateful(),
          ),
        ),
      ),
    );
  }

  group('Sign In', () {
    testWidgets(
        'WHEN user doesn\'t enter email and password'
        'AND taps on sign in button'
        'THEN signInWithEmailAndPassword is not called',
        (WidgetTester widgetTester) async {
      await pumpEmailSignInForm(widgetTester);
      final signInButton = find.text('Sign In');
      await widgetTester.tap(signInButton);

      verifyNever(mockAuth.signInWithEmailAndPassword(any, any));
    });

    testWidgets(
        'WHEN user enters email and password'
        'AND taps on sign in button'
        'THEN signInWithEmailAndPassword is called',
        (WidgetTester widgetTester) async {
      await pumpEmailSignInForm(widgetTester);

      const email = 'email@email.com';
      const password = 'password';

      final emailTextField = find.byKey(Key('email'));
      expect(emailTextField, findsOneWidget);
      await widgetTester.enterText(emailTextField, email);

      final passwordTextField = find.byKey(Key('password'));
      expect(passwordTextField, findsOneWidget);
      await widgetTester.enterText(passwordTextField, password);

      await widgetTester.pump();

      final signInButton = find.text('Sign In');
      await widgetTester.tap(signInButton);

      verify(mockAuth.signInWithEmailAndPassword(email, password)).called(1);
    });
  });
}
