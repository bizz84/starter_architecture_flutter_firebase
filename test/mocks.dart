import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:starter_architecture_flutter_firebase/services/firestore_database.dart';
import 'package:firebase_auth_service/firebase_auth_service.dart';

class MockAuthService extends Mock implements FirebaseAuthService {}

class MockDatabase extends Mock implements FirestoreDatabase {}

class MockWidgetsBinding extends Mock implements WidgetsBinding {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
