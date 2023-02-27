import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_architecture_flutter_firebase/src/common_widgets/custom_text_button.dart';
import 'package:starter_architecture_flutter_firebase/src/common_widgets/primary_button.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/presentation/email_password/email_password_sign_in_form_type.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/presentation/email_password/email_password_sign_in_screen.dart';

import '../../mocks.dart';

class AuthRobot {
  AuthRobot(this.tester);
  final WidgetTester tester;

  Future<void> pumpEmailPasswordSignInContents({
    required MockFirebaseAuth mockFirebaseAuth,
    required EmailPasswordSignInFormType formType,
  }) {
    return tester.pumpWidget(
      ProviderScope(
        overrides: [
          firebaseAuthProvider.overrideWithValue(mockFirebaseAuth),
        ],
        child: MaterialApp(
          home: EmailPasswordSignInScreen(
            formType: formType,
          ),
        ),
      ),
    );
  }

  Future<void> tapEmailAndPasswordSubmitButton() async {
    final primaryButton = find.byType(PrimaryButton);
    expect(primaryButton, findsOneWidget);
    await tester.tap(primaryButton);
    await tester.pumpAndSettle();
  }

  Future<void> tapFormToggleButton() async {
    final toggleButton = find.byType(CustomTextButton);
    expect(toggleButton, findsOneWidget);
    await tester.tap(toggleButton);
    await tester.pumpAndSettle();
  }

  Future<void> enterEmail(String email) async {
    final emailField = find.byKey(EmailPasswordSignInScreen.emailKey);
    expect(emailField, findsOneWidget);
    await tester.enterText(emailField, email);
  }

  Future<void> enterPassword(String password) async {
    final passwordField = find.byKey(EmailPasswordSignInScreen.passwordKey);
    expect(passwordField, findsOneWidget);
    await tester.enterText(passwordField, password);
  }

  void expectEmailAndPasswordFieldsFound() {
    final emailField = find.byKey(EmailPasswordSignInScreen.emailKey);
    expect(emailField, findsOneWidget);
    final passwordField = find.byKey(EmailPasswordSignInScreen.passwordKey);
    expect(passwordField, findsOneWidget);
  }

  void expectCreateAccountButtonFound() {
    final dialogTitle = find.text('Create an account');
    expect(dialogTitle, findsOneWidget);
  }

  void expectCreateAccountButtonNotFound() {
    final dialogTitle = find.text('Create an account');
    expect(dialogTitle, findsNothing);
  }

  Future<void> enterAndSubmitEmailAndPassword() async {
    await enterEmail('test@test.com');
    await enterPassword('test1234');
    await tapEmailAndPasswordSubmitButton();
  }

  void expectErrorAlertFound() {
    final finder = find.text('Error');
    expect(finder, findsOneWidget);
  }

  void expectErrorAlertNotFound() {
    final finder = find.text('Error');
    expect(finder, findsNothing);
  }

  void expectCircularProgressIndicator() {
    final finder = find.byType(CircularProgressIndicator);
    expect(finder, findsOneWidget);
  }
}
