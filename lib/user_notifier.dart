import 'dart:async';

import 'package:firebase_auth_service/firebase_auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

final authServiceProvider = Provider((_) => FirebaseAuthService());
final userNotifierProvider = StateNotifierProvider((ref) => UserNotifier(ref));

class UserNotifier extends StateNotifier<User> {
  UserNotifier(this._ref) : super(null) {
    final authService = authServiceProvider.read(_ref);
    _onAuthStateChangedSubscription =
        authService.onAuthStateChanged.listen((user) {
      state = user;
    });
  }

  final ProviderReference _ref;
  StreamSubscription _onAuthStateChangedSubscription;

  @override
  void dispose() {
    _onAuthStateChangedSubscription?.cancel();
    super.dispose();
  }
}
