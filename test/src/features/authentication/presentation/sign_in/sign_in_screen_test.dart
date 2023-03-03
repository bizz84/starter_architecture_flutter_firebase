import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/presentation/email_password/email_password_sign_in_form_type.dart';

import '../../../../mocks.dart';
import '../../auth_robot.dart';

// Example widget tests showing how to mock the data source (FirebaseAuth),
// rather than the repository (AuthRepository).
void main() {
  const testEmail = 'test@test.com';
  const testPassword = 'testPassword';

  testWidgets('''
        Given formType is signIn
        When tap on the sign-in button
        Then signInWithEmailAndPassword is not called
        ''', (tester) async {
    final r = AuthRobot(tester);
    final mockFirebaseAuth = MockFirebaseAuth();
    final mockUserCredential = MockUserCredential();
    when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: testEmail, password: testPassword))
        .thenAnswer((_) => Future.value(mockUserCredential));
    await r.pumpEmailPasswordSignInContents(
      mockFirebaseAuth: mockFirebaseAuth,
      formType: EmailPasswordSignInFormType.signIn,
    );

    await r.tapEmailAndPasswordSubmitButton();

    verifyNever(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ));
  });

  testWidgets('''
        Given formType is signIn
        When enter valid email and password
        And tap on the sign-in button
        Then signInWithEmailAndPassword is called
        And error alert is not shown
        ''', (tester) async {
    final r = AuthRobot(tester);
    final mockFirebaseAuth = MockFirebaseAuth();
    final mockUserCredential = MockUserCredential();
    when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: testEmail, password: testPassword))
        .thenAnswer((_) => Future.value(mockUserCredential));
    await r.pumpEmailPasswordSignInContents(
      mockFirebaseAuth: mockFirebaseAuth,
      formType: EmailPasswordSignInFormType.signIn,
    );
    await r.enterEmail(testEmail);
    await r.enterPassword(testPassword);
    await r.tapEmailAndPasswordSubmitButton();
    verify(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: testEmail,
          password: testPassword,
        )).called(1);
    r.expectErrorAlertNotFound();
  });
}
