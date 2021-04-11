import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:starter_architecture_flutter_firebase/app/home/account/components/body.dart';
import 'package:starter_architecture_flutter_firebase/app/top_level_providers.dart';
import 'package:alert_dialogs/alert_dialogs.dart';
import 'package:starter_architecture_flutter_firebase/constants/keys.dart';
import 'package:starter_architecture_flutter_firebase/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';

class AccountPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context, FirebaseAuth firebaseAuth) async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      unawaited(showExceptionAlertDialog(
        context: context,
        title: Strings.logoutFailed,
        exception: e,
      ));
    }
  }

  Future<void> _confirmSignOut(
      BuildContext context, FirebaseAuth firebaseAuth) async {
    final bool didRequestSignOut = await showAlertDialog(
          context: context,
          title: Strings.logout,
          content: Strings.logoutAreYouSure,
          cancelActionText: Strings.cancel,
          defaultActionText: Strings.logout,
        ) ??
        false;
    if (didRequestSignOut == true) {
      await _signOut(context, firebaseAuth);
    }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = context.read(firebaseAuthProvider);
    final user = firebaseAuth.currentUser!;
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.accountPage),
          actions: <Widget>[
            FlatButton(
              key: const Key(Keys.logout),
              child: const Text(
                Strings.logout,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () => _confirmSignOut(context, firebaseAuth),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(220.0),
            child: _buildUserInfo(user),
          ),
        ),
        body: Container(
            margin: new EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (user.email != null)
                  Text(
                    'Email:   ' + user.email!,
                    style: const TextStyle(
                        color: Colors.black, height: 3, fontSize: 25),
                  ),
              ],
            ))

        // body: Body(),
        );
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          width: 280,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(
                    'https://images.pexels.com/photos/1310522/pexels-photo-1310522.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
                fit: BoxFit.fill),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
