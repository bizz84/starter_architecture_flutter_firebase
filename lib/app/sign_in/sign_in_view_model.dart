import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth_service/firebase_auth_service.dart';

class SignInViewModel with ChangeNotifier {
  SignInViewModel({@required this.auth});
  final FirebaseAuthService auth;
  bool isLoading = false;

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      isLoading = true;
      notifyListeners();
      return await signInMethod();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<User> signInAnonymously() async {
    return _signIn(auth.signInAnonymously);
  }
}
