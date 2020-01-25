import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:starter_architecture_flutter_firebase/services/firebase_auth_service.dart';

class SignInManager {
  SignInManager({@required this.auth, @required this.isLoading});
  final FirebaseAuthService auth;
  final ValueNotifier<bool> isLoading;

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<User> signInAnonymously() async {
    return await _signIn(auth.signInAnonymously);
  }
}
