import 'dart:async';

import 'package:starter_architecture_flutter_firebase/app/sign_in/sign_in_view_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:starter_architecture_flutter_firebase/services/firebase_auth_service.dart';

import 'mocks.dart';

void main() {
  MockAuthService mockAuthService;
  SignInViewModel viewModel;

  setUp(() {
    mockAuthService = MockAuthService();
    viewModel = SignInViewModel(auth: mockAuthService);
  });

  tearDown(() {
    mockAuthService = null;
    viewModel = null;
  });

  void stubSignInAnonymouslyReturnsUser() {
    when(mockAuthService.signInAnonymously())
        .thenAnswer((_) => Future<User>.value(const User(uid: '123')));
  }

  void stubSignInAnonymouslyThrows(Exception exception) {
    when(mockAuthService.signInAnonymously()).thenThrow(exception);
  }

  test(
      'WHEN view model signs in anonymously'
      'AND auth returns valid user'
      'THEN isLoading is true', () async {
    stubSignInAnonymouslyReturnsUser();

    await viewModel.signInAnonymously();

    expect(viewModel.isLoading, true);
  });

  test(
      'WHEN view model signs in anonymously'
      'AND auth throws an exception'
      'THEN view model throws an exception'
      'THEN isLoading is false', () async {
    final exception = PlatformException(code: 'ERROR_MISSING_PERMISSIONS');
    stubSignInAnonymouslyThrows(exception);

    expect(() => viewModel.signInAnonymously(), throwsA(exception));

    expect(viewModel.isLoading, false);
  });
}
