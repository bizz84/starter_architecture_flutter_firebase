import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:starter_architecture_flutter_firebase/services/firestore_database.dart';

final authServiceProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final databaseProvider =
    ScopedProvider<FirestoreDatabase>((ref) => throw UnimplementedError());

final loggerProvider = Provider<Logger>((ref) => Logger(
      printer: PrettyPrinter(
        methodCount: 1,
        printEmojis: false,
      ),
    ));
