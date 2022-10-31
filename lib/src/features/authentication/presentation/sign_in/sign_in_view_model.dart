import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class SignInViewModel with ChangeNotifier {
  SignInViewModel({required this.auth});
  final FirebaseAuth auth;
  bool isLoading = false;
  dynamic error;

  Future<void> _signIn(Future<UserCredential> Function() signInMethod) async {
    try {
      isLoading = true;
      notifyListeners();
      await signInMethod();
      error = null;
    } catch (e) {
      error = e;
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInAnonymously() async {
    await _signIn(auth.signInAnonymously);
  }
}
