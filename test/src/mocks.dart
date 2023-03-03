import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/onboarding/data/onboarding_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

class MockOnboardingRepository extends Mock implements OnboardingRepository {}

class Listener<T> extends Mock {
  void call(T? previous, T? next);
}
