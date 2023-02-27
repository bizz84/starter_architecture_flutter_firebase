import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/data/firebase_auth_repository.dart';

import '../../../mocks.dart';

void main() {
  const testEmail = 'test@test.com';
  const testPassword = 'testPassword';
  test('signInWithEmailAndPassword success, returns user credential', () async {
    final mockFirebaseAuth = MockFirebaseAuth();
    final authRepository = AuthRepository(mockFirebaseAuth);
    final mockUserCredential = MockUserCredential();
    final mockUser = MockUser();
    when(() => mockUser.email).thenReturn(testEmail);
    when(() => mockUserCredential.user).thenReturn(mockUser);
    when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: testEmail, password: testPassword))
        .thenAnswer((_) => Future.value(mockUserCredential));
    final credential = await authRepository.signInWithEmailAndPassword(
        testEmail, testPassword);
    expect(credential.user, isNotNull);
    expect(credential.user!.email, testEmail);
  });
}
