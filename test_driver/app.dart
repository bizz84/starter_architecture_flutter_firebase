// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mockito/mockito.dart';
// import 'package:starter_architecture_flutter_firebase/app/top_level_providers.dart';
// import 'package:starter_architecture_flutter_firebase/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_driver/driver_extension.dart';
// import 'package:starter_architecture_flutter_firebase/services/firestore_database.dart';

// import 'fake_auth_service.dart';

// class MockDatabase extends Mock implements FirestoreDatabase {}

// // Run with:
// // flutter drive --target=test_driver/app.dart
// Future<void> main() async {
//   // This line enables the extension.
//   enableFlutterDriverExtension();

//   // TODO: Somehow Firebase.initializeApp() is required when running this driver test
//   // Need to figure out what code path triggers this as both FirebaseAuth and Firestore are mocked
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   // Call the `main()` function of the app, or call `runApp` with
//   // any widget you are interested in testing.
//   runApp(ProviderScope(
//     overrides: [
//       firebaseAuthProvider
//           .overrideWithProvider(Provider((ref) => FakeAuthService())),
//       databaseProvider.overrideWithProvider(Provider((ref) => MockDatabase())),
//     ],
//     child: MyApp(),
//   ));
// }
