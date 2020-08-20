import 'dart:async';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:random_string/random_string.dart' as random;
import 'package:firebase_auth_service/firebase_auth_service.dart';

// TODO: Move to firebase_auth_service package
/// Fake authentication service to be used for testing the UI
/// Keeps an in-memory store of registered accounts so that registration and sign in flows can be tested.
class FakeAuthService implements FirebaseAuthService {
  FakeAuthService({
    this.startupTime = const Duration(milliseconds: 250),
    this.responseTime = const Duration(seconds: 2),
  }) {
    Future<void>.delayed(responseTime).then((_) {
      _add(null);
    });
  }
  final Duration startupTime;
  final Duration responseTime;

  final Map<String, _UserData> _usersStore = <String, _UserData>{};

  AppUser _currentUser;

  final StreamController<AppUser> _onAuthStateChangedController =
      StreamController<AppUser>();
  @override
  Stream<AppUser> authStateChanges() => _onAuthStateChangedController.stream;

  @override
  AppUser get currentUser => _currentUser;

  @override
  Future<AppUser> createUserWithEmailAndPassword(
      String email, String password) async {
    await Future<void>.delayed(responseTime);
    if (_usersStore.keys.contains(email)) {
      throw PlatformException(
        code: 'ERROR_EMAIL_ALREADY_IN_USE',
        message: 'The email address is already registered. Sign in instead?',
      );
    }
    final AppUser user =
        AppUser(uid: random.randomAlphaNumeric(32), email: email);
    _usersStore[email] = _UserData(password: password, user: user);
    _add(user);
    return user;
  }

  @override
  Future<AppUser> signInWithEmailAndPassword(
      String email, String password) async {
    await Future<void>.delayed(responseTime);
    if (!_usersStore.keys.contains(email)) {
      throw PlatformException(
        code: 'ERROR_USER_NOT_FOUND',
        message: 'The email address is not registered. Need an account?',
      );
    }
    final _UserData _userData = _usersStore[email];
    if (_userData.password != password) {
      throw PlatformException(
        code: 'ERROR_WRONG_PASSWORD',
        message: 'The password is incorrect. Please try again.',
      );
    }
    _add(_userData.user);
    return _userData.user;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {}

  @override
  Future<void> signOut() async {
    _add(null);
  }

  void _add(AppUser user) {
    _currentUser = user;
    _onAuthStateChangedController.add(user);
  }

  @override
  Future<AppUser> signInAnonymously() async {
    await Future<void>.delayed(responseTime);
    final AppUser user = AppUser(uid: random.randomAlphaNumeric(32));
    _add(user);
    return user;
  }

  void dispose() {
    _onAuthStateChangedController.close();
  }
}

class _UserData {
  _UserData({@required this.password, @required this.user});
  final String password;
  final AppUser user;
}
