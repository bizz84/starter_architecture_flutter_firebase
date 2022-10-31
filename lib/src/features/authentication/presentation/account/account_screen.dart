import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/src/common_widgets/avatar.dart';
import 'package:starter_architecture_flutter_firebase/src/constants/keys.dart';
import 'package:starter_architecture_flutter_firebase/src/constants/strings.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/utils/alert_dialogs.dart';

// TODO create corresponding notifier
class AccountScreen extends ConsumerWidget {
  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(authRepositoryProvider).signOut();
    } catch (e) {
      unawaited(showExceptionAlertDialog(
        context: context,
        title: Strings.logoutFailed,
        exception: e,
      ));
    }
  }

  Future<void> _confirmSignOut(BuildContext context, WidgetRef ref) async {
    final bool didRequestSignOut = await showAlertDialog(
          context: context,
          title: Strings.logout,
          content: Strings.logoutAreYouSure,
          cancelActionText: Strings.cancel,
          defaultActionText: Strings.logout,
        ) ??
        false;
    if (didRequestSignOut == true) {
      await _signOut(context, ref);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.accountPage),
        actions: <Widget>[
          TextButton(
            key: const Key(Keys.logout),
            child: const Text(
              Strings.logout,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmSignOut(context, ref),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(130.0),
          child: Column(
            children: [
              Avatar(
                photoUrl: user.photoURL,
                radius: 50,
                borderColor: Colors.black54,
                borderWidth: 2.0,
              ),
              const SizedBox(height: 8),
              if (user.displayName != null)
                Text(
                  user.displayName!,
                  style: const TextStyle(color: Colors.white),
                ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
