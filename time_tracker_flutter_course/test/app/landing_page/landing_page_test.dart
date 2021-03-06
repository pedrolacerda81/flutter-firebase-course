import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/home/home_page.dart';
import 'package:time_tracker_flutter_course/app/landing_page/landing_page.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_page.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import '../../mocks/mocks.dart';

void main() {

  MockAuth mockAuth;
  StreamController<User> onAuthStateChangedController;

  setUp(() {
    mockAuth = MockAuth();
    onAuthStateChangedController = StreamController<User>();
  });

  tearDown(() {
    onAuthStateChangedController.close();
  });

  Future<void> pumpLandingPage(WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(
      Provider<AuthBase>(
        create: (_) => mockAuth,
        child: MaterialApp(
          home: LandingPage(),
        ),
      ),
    );
    await widgetTester.pump();
  }

  void stubOnAuthStateChangedYields(Iterable<User> onAuthStateChange) {
    onAuthStateChangedController.addStream(Stream<User>.fromIterable(onAuthStateChange));
    when(mockAuth.onAuthStateChanged).thenAnswer((_) {
      return onAuthStateChangedController.stream;
    });
  }

  group('Landing Page Stream', () {
    testWidgets('Stream waiting', (WidgetTester widgetTester) async {
      stubOnAuthStateChangedYields([]);

      await pumpLandingPage(widgetTester);
      
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Null user', (WidgetTester widgetTester) async {
      stubOnAuthStateChangedYields([null]);

      await pumpLandingPage(widgetTester);

      expect(find.byType(SignInPage), findsOneWidget);
    });

    testWidgets('Non null user', (WidgetTester widgetTester) async {
      stubOnAuthStateChangedYields([User(uid: '123')]);

      await pumpLandingPage(widgetTester);

      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}