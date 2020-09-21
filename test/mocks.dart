import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:starter_architecture_flutter_firebase/services/firestore_database.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockDatabase extends Mock implements FirestoreDatabase {}

class MockWidgetsBinding extends Mock implements WidgetsBinding {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}
