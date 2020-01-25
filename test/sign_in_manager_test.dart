import 'dart:async';

import 'package:starter_architecture_flutter_firebase/app/sign_in/sign_in_manager.dart';
import 'package:starter_architecture_flutter_firebase/services/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks.dart';

class MockValueNotifier<T> extends ValueNotifier<T> {
  MockValueNotifier(T value) : super(value);

  List<T> values = <T>[];

  @override
  set value(T newValue) {
    values.add(newValue);
    super.value = newValue;
  }
}

void main() {
  MockAuthService mockAuthService;
  SignInManager manager;
  MockValueNotifier<bool> isLoading;

  setUp(() {
    mockAuthService = MockAuthService();
    isLoading = MockValueNotifier<bool>(false);
    manager = SignInManager(auth: mockAuthService, isLoading: isLoading);
  });

  tearDown(() {
    mockAuthService = null;
    manager = null;
    isLoading = null;
  });

  void stubSignInAnonymouslyReturnsUser() {
    when(mockAuthService.signInAnonymously())
        .thenAnswer((_) => Future<User>.value(User(uid: '123')));
  }

  void stubSignInAnonymouslyThrows(Exception exception) {
    when(mockAuthService.signInAnonymously()).thenThrow(exception);
  }

  test(
      'WHEN manager signs in anonymously'
      'AND auth returns valid user'
      'THEN isLoading values are [ true ]', () async {
    stubSignInAnonymouslyReturnsUser();

    await manager.signInAnonymously();

    expect(isLoading.values, <bool>[true]);
  });

  test(
      'WHEN manager signs in anonymously'
      'AND auth throws an exception'
      'THEN manager throws an exception'
      'THEN isLoading values are [ true, false ]', () async {
    final exception = PlatformException(code: 'ERROR_MISSING_PERMISSIONS');
    stubSignInAnonymouslyThrows(exception);

    expect(() async => await manager.signInAnonymously(), throwsA(exception));

    expect(isLoading.values, <bool>[true, false]);
  });
}
