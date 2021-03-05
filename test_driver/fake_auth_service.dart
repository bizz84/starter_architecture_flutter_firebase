// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth_platform_interface/src/auth_provider.dart';
// import 'package:flutter/services.dart';
// import 'package:meta/meta.dart';
// import 'package:mockito/mockito.dart';
// import 'package:random_string/random_string.dart' as random;

// class MockUser extends Mock implements User {}

// class MockUserCredential extends Mock implements UserCredential {}

// /// Fake authentication service to be used for testing the UI
// /// Keeps an in-memory store of registered accounts so that registration and sign in flows can be tested.
// class FakeAuthService implements FirebaseAuth {
//   FakeAuthService({
//     this.startupTime = const Duration(milliseconds: 250),
//     this.responseTime = const Duration(seconds: 2),
//   }) {
//     Future<void>.delayed(responseTime).then((_) {
//       _add(null);
//     });
//   }
//   final Duration startupTime;
//   final Duration responseTime;

//   final Map<String, _UserData> _usersStore = <String, _UserData>{};

//   User _currentUser;

//   final StreamController<User> _onAuthStateChangedController =
//       StreamController<User>();
//   @override
//   Stream<User> authStateChanges() => _onAuthStateChangedController.stream;

//   @override
//   User get currentUser => _currentUser;

//   UserCredential _mockUserCredential(
//       {String uid, String email, String password}) {
//     final user = MockUser();
//     when(user.uid).thenReturn(uid);
//     when(user.email).thenReturn(email);
//     final userCredential = MockUserCredential();
//     when(userCredential.user).thenReturn(user);
//     return userCredential;
//   }

//   @override
//   Future<UserCredential> createUserWithEmailAndPassword(
//       {required String email, required String password}) async {
//     await Future<void>.delayed(responseTime);
//     if (_usersStore.keys.contains(email)) {
//       throw PlatformException(
//         code: 'ERROR_EMAIL_ALREADY_IN_USE',
//         message: 'The email address is already registered. Sign in instead?',
//       );
//     }
//     final userCredential = _mockUserCredential(
//       uid: random.randomAlphaNumeric(32),
//       email: email,
//       password: password,
//     );
//     _usersStore[email] =
//         _UserData(password: password, user: userCredential.user);
//     _add(userCredential.user);
//     return userCredential;
//   }

//   @override
//   Future<UserCredential> signInWithCredential(AuthCredential credential) async {
//     if (credential is EmailAuthCredential) {
//       return signInWithEmailAndPassword(
//           email: credential.email, password: credential.password);
//     }
//     // TODO: implement signInWithCredential
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserCredential> signInWithEmailAndPassword(
//       {String email, String password}) async {
//     // TODO: implement signInWithEmailAndPassword
//     await Future<void>.delayed(responseTime);
//     if (!_usersStore.keys.contains(email)) {
//       throw PlatformException(
//         code: 'ERROR_USER_NOT_FOUND',
//         message: 'The email address is not registered. Need an account?',
//       );
//     }
//     final _UserData _userData = _usersStore[email];
//     if (_userData.password != password) {
//       throw PlatformException(
//         code: 'ERROR_WRONG_PASSWORD',
//         message: 'The password is incorrect. Please try again.',
//       );
//     }
//     _add(_userData.user);
//     final userCredential = _mockUserCredential(
//       uid: _userData.user.uid,
//       email: email,
//       password: password,
//     );
//     return userCredential;
//   }

//   @override
//   Future<void> signOut() async {
//     _add(null);
//   }

//   void _add(User user) {
//     _currentUser = user;
//     _onAuthStateChangedController.add(user);
//   }

//   @override
//   Future<UserCredential> signInAnonymously() async {
//     await Future<void>.delayed(responseTime);
//     final userCredential = _mockUserCredential(
//       uid: random.randomAlphaNumeric(32),
//       email: null,
//       password: null,
//     );
//     _add(userCredential.user);
//     return userCredential;
//   }

//   void dispose() {
//     _onAuthStateChangedController.close();
//   }

//   @override
//   FirebaseApp app;

//   @override
//   Future<void> applyActionCode(String code) {
//     // TODO: implement applyActionCode
//     throw UnimplementedError();
//   }

//   @override
//   Future<ActionCodeInfo> checkActionCode(String code) {
//     // TODO: implement checkActionCode
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> confirmPasswordReset({String code, String newPassword}) {
//     // TODO: implement confirmPasswordReset
//     throw UnimplementedError();
//   }

//   @override
//   Future<List<String>> fetchSignInMethodsForEmail(String email) {
//     // TODO: implement fetchSignInMethodsForEmail
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserCredential> getRedirectResult() {
//     // TODO: implement getRedirectResult
//     throw UnimplementedError();
//   }

//   @override
//   Stream<User> idTokenChanges() {
//     // TODO: implement idTokenChanges
//     throw UnimplementedError();
//   }

//   @override
//   bool isSignInWithEmailLink(String emailLink) {
//     // TODO: implement isSignInWithEmailLink
//     throw UnimplementedError();
//   }

//   @override
//   // TODO: implement languageCode
//   String get languageCode => throw UnimplementedError();

//   @override
//   // TODO: implement onAuthStateChanged
//   Stream<User> get onAuthStateChanged => throw UnimplementedError();

//   @override
//   // TODO: implement pluginConstants
//   Map get pluginConstants => throw UnimplementedError();

//   @override
//   Future<void> sendSignInLinkToEmail(
//       {String email, ActionCodeSettings actionCodeSettings}) {
//     // TODO: implement sendSignInLinkToEmail
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> setLanguageCode(String languageCode) {
//     // TODO: implement setLanguageCode
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> setPersistence(Persistence persistence) {
//     // TODO: implement setPersistence
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> setSettings(
//       {bool appVerificationDisabledForTesting, String userAccessGroup}) {
//     // TODO: implement setSettings
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserCredential> signInWithCustomToken(String token) {
//     // TODO: implement signInWithCustomToken
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserCredential> signInWithEmailLink({String email, String emailLink}) {
//     // TODO: implement signInWithEmailLink
//     throw UnimplementedError();
//   }

//   @override
//   Future<ConfirmationResult> signInWithPhoneNumber(
//       String phoneNumber, RecaptchaVerifier verifier) {
//     // TODO: implement signInWithPhoneNumber
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserCredential> signInWithPopup(AuthProvider provider) {
//     // TODO: implement signInWithPopup
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> signInWithRedirect(AuthProvider provider) {
//     // TODO: implement signInWithRedirect
//     throw UnimplementedError();
//   }

//   @override
//   Stream<User> userChanges() {
//     // TODO: implement userChanges
//     throw UnimplementedError();
//   }

//   @override
//   Future<String> verifyPasswordResetCode(String code) {
//     // TODO: implement verifyPasswordResetCode
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> verifyPhoneNumber(
//       {String phoneNumber,
//       verificationCompleted,
//       verificationFailed,
//       codeSent,
//       codeAutoRetrievalTimeout,
//       String autoRetrievedSmsCodeForTesting,
//       Duration timeout = const Duration(seconds: 30),
//       int forceResendingToken}) {
//     // TODO: implement verifyPhoneNumber
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> sendPasswordResetEmail(
//       {String email, ActionCodeSettings actionCodeSettings}) {
//     // TODO: implement sendPasswordResetEmail
//     throw UnimplementedError();
//   }
// }

// class _UserData {
//   _UserData({required this.password, required this.user});
//   final String password;
//   final User user;
// }
