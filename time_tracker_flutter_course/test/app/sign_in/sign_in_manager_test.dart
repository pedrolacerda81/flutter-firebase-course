import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:time_tracker_flutter_course/app/sign_in/sign_in_manager.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import '../../mocks/mocks.dart';

class MockValueNotifier<T> extends ValueNotifier<T> {
  MockValueNotifier(T value) : super(value);
  List<T> values = [];

  @override
  set value(T newValue) {
    values.add(newValue);
    super.value = newValue;
  }
}

void main() {
  MockAuth mockAuth;
  MockValueNotifier<bool> isLoading;
  SignInManager manager;

  setUp(() {
    mockAuth = MockAuth();
    isLoading = MockValueNotifier<bool>(false);
    manager = SignInManager(auth: mockAuth, isLoading: isLoading);
  });

  test('Sign in - SUCCESS', () async {
    when(mockAuth.signInAnonymously())
        .thenAnswer((_) => Future.value(User(uid: '123')));
    await manager.signInAnonymously();
    expect(isLoading.values, [true]);
  });

  test('Sign in - FAILURE', () async {
    when(mockAuth.signInAnonymously())
        .thenThrow(PlatformException(code: 'ERROR', message: 'Sign-in failed'));

    try {
      await manager.signInAnonymously();
    } catch (e) {
      expect(isLoading.values, [true, false]);
    }
  });
}
