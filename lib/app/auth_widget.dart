import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/app/providers.dart';
import 'package:starter_architecture_flutter_firebase/services/firestore_database.dart';

class AuthWidget extends ConsumerWidget {
  const AuthWidget({
    Key key,
    @required this.signedInBuilder,
    @required this.nonSignedInBuilder,
  }) : super(key: key);
  final WidgetBuilder nonSignedInBuilder;
  final WidgetBuilder signedInBuilder;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final firebaseAuth = watch(firebaseAuthProvider);
    final authStateChangesProvider =
        StreamProvider<User>((ref) => firebaseAuth.authStateChanges());
    final authStateChanges = watch(authStateChangesProvider);
    return authStateChanges.when<Widget>(
      data: (user) => _data(context, user),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, __) => const Scaffold(
        body: Center(
          child: Text('Error reading authStateChanges()'),
        ),
      ),
    );
  }

  Widget _data(BuildContext context, User user) {
    if (user != null) {
      return ProviderScope(
        overrides: [
          databaseProvider
              .overrideAs((watch) => FirestoreDatabase(uid: user.uid)),
        ],
        child: signedInBuilder(context),
      );
    }
    return nonSignedInBuilder(context);
  }
}
