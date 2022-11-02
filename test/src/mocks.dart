import 'package:mocktail/mocktail.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/data/firebase_auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class Listener<T> extends Mock {
  void call(T? previous, T? next);
}
