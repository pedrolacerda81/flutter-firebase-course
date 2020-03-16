import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sign_in/email_sign_in_form_stateful.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import '../../mocks/mocks.dart';


void main() {
  MockAuth mockAuth;
  setUp(() {
    mockAuth = MockAuth();
  });

  Future<void> pumpEmailSignInForm(WidgetTester widgetTester,
      {VoidCallback onSignedIn}) async {
    await widgetTester.pumpWidget(
      Provider<AuthBase>(
        create: (_) => mockAuth,
        child: MaterialApp(
          home: Scaffold(
            body: EmailSignInFormStateful(
              onSignedIn: onSignedIn,
            ),
          ),
        ),
      ),
    );
  }

  void stubSignInWithEmailAndPasswordSucceeds() {
    when(mockAuth.signInWithEmailAndPassword(any, any))
        .thenAnswer((_) => Future<User>.value(User(uid: '123')));
  }

  void stubSignInWithEmailAndPasswordThrows() {
    when(mockAuth.signInWithEmailAndPassword(any, any))
        .thenThrow(PlatformException(code: 'ERROR_WRONG_PASSWORD'));
  }

  group('Sign In', () {
    testWidgets(
        'WHEN user doesn\'t enter email and password'
        'AND taps on sign in button'
        'THEN signInWithEmailAndPassword is not called'
        'AND user is not signed-in', (WidgetTester widgetTester) async {
      var signedIn = false;
      await pumpEmailSignInForm(widgetTester,
          onSignedIn: () => signedIn = true);

      final signInButton = find.text('Sign In');
      await widgetTester.tap(signInButton);

      verifyNever(mockAuth.signInWithEmailAndPassword(any, any));
      expect(signedIn, false);
    });

    testWidgets(
        'WHEN user enters email and password'
        'AND taps on sign in button'
        'THEN signInWithEmailAndPassword is called'
        'AND the user is signed-in', (WidgetTester widgetTester) async {
      var signedIn = false;
      await pumpEmailSignInForm(widgetTester,
          onSignedIn: () => signedIn = true);

      stubSignInWithEmailAndPasswordSucceeds();

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
      expect(signedIn, true);
    });

    testWidgets(
        'WHEN user enters an invalid email and password'
            'AND taps on sign in button'
            'THEN signInWithEmailAndPassword is called'
            'AND the user is not signed-in', (WidgetTester widgetTester) async {
      var signedIn = false;
      await pumpEmailSignInForm(widgetTester,
          onSignedIn: () => signedIn = true);

      stubSignInWithEmailAndPasswordThrows();

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
      expect(signedIn, false);
    });
  });

  group('Register', () {
    testWidgets(
        'WHEN user taps on the secondary button'
        'THEN form toggles to registration mode',
        (WidgetTester widgetTester) async {
      await pumpEmailSignInForm(widgetTester);

      final registerButton = find.text('Need an accont? Register');
      await widgetTester.tap(registerButton);

      await widgetTester.pump();

      final createAnAccountButton = find.text('Creat an account');
      expect(createAnAccountButton, findsOneWidget);
    });

    testWidgets(
        'WHEN user taps on the secondary button'
        'AND user enters the email and password'
        'AND taps on register button'
        'THEN createUserWithEmailAndPassword is called',
        (WidgetTester widgetTester) async {
      await pumpEmailSignInForm(widgetTester);

      const email = 'email@email.com';
      const password = 'password';

      final registerButton = find.text('Need an accont? Register');
      await widgetTester.tap(registerButton);

      await widgetTester.pump();

      final emailTextField = find.byKey(Key('email'));
      expect(emailTextField, findsOneWidget);
      await widgetTester.enterText(emailTextField, email);

      final passwordTextField = find.byKey(Key('password'));
      expect(passwordTextField, findsOneWidget);
      await widgetTester.enterText(passwordTextField, password);

      await widgetTester.pump();

      final createAnAccountButton = find.text('Creat an account');
      expect(createAnAccountButton, findsOneWidget);
      await widgetTester.tap(createAnAccountButton);

      verify(mockAuth.createUserWithEmailAndPassword(email, password))
          .called(1);
    });
  });
}
