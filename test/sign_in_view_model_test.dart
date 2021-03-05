import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:starter_architecture_flutter_firebase/app/sign_in/sign_in_view_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'sign_in_view_model_test.mocks.dart';

@GenerateMocks([FirebaseAuth, UserCredential])
void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late SignInViewModel viewModel;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    viewModel = SignInViewModel(auth: mockFirebaseAuth);
  });

  void stubSignInAnonymouslyReturnsUser() {
    when(mockFirebaseAuth.signInAnonymously())
        .thenAnswer((_) => Future.value(MockUserCredential()));
  }

  void stubSignInAnonymouslyThrows(Exception exception) {
    when(mockFirebaseAuth.signInAnonymously()).thenThrow(exception);
  }

  test(
      'WHEN view model signs in anonymously'
      'AND auth returns valid user'
      'THEN isLoading is false', () async {
    stubSignInAnonymouslyReturnsUser();

    await viewModel.signInAnonymously();

    expect(viewModel.isLoading, false);
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
