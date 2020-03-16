import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_page.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import '../../mocks/mocks.dart';

void main() {
  MockAuth mockAuth;
  MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockAuth = MockAuth();
    mockNavigatorObserver = MockNavigatorObserver();
  });

  Future<void> pumpSignInPage(WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(
      Provider<AuthBase>(
        create: (_) => mockAuth,
        child: MaterialApp(
          home: Builder(
            builder: (context) => SignInPage.create(context),
          ),
          navigatorObservers: [mockNavigatorObserver],
        ),
      ),
    );
    verify(mockNavigatorObserver.didPush(any, any)).called(1);
  }

  group('Sign In Page', () {
    testWidgets('Email & password', (WidgetTester widgetTester) async {
      await pumpSignInPage(widgetTester);

      final emailSignInButton = find.byKey(SignInPage.emailPasswordKey);
      expect(emailSignInButton, findsOneWidget);

      await widgetTester.tap(emailSignInButton);
      await widgetTester.pumpAndSettle();

      verify(mockNavigatorObserver.didPush(any, any)).called(1);
    });
  });
}