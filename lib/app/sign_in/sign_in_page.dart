import 'dart:math';

import 'package:alert_dialogs/alert_dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:starter_architecture_flutter_firebase/app/sign_in/sign_in_view_model.dart';
import 'package:starter_architecture_flutter_firebase/app/sign_in/sign_in_button.dart';
import 'package:starter_architecture_flutter_firebase/constants/keys.dart';
import 'package:starter_architecture_flutter_firebase/constants/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_architecture_flutter_firebase/routing/app_router.dart';

class SignInPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = Provider.of<FirebaseAuth>(context, listen: false);
    return ChangeNotifierProvider<SignInViewModel>(
      create: (_) => SignInViewModel(auth: auth),
      child: Consumer<SignInViewModel>(
        builder: (_, viewModel, __) => SignInPage._(
          viewModel: viewModel,
          title: 'Architecture Demo',
        ),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage._({Key key, this.viewModel, this.title}) : super(key: key);
  final SignInViewModel viewModel;
  final String title;

  static const Key emailPasswordButtonKey = Key(Keys.emailPassword);
  static const Key anonymousButtonKey = Key(Keys.anonymous);

  Future<void> _showSignInError(BuildContext context, dynamic exception) async {
    await showExceptionAlertDialog(
      context: context,
      title: Strings.signInFailed,
      exception: exception,
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await viewModel.signInAnonymously();
    } catch (e) {
      await _showSignInError(context, e);
    }
  }

  Future<void> _showEmailPasswordSignInPage(BuildContext context) async {
    final navigator = Navigator.of(context);
    await navigator.pushNamed(
      AppRoutes.emailPasswordSignInPage,
      arguments: () => navigator.pop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(title),
      ),
      backgroundColor: Colors.grey[200],
      body: _buildSignIn(context),
    );
  }

  Widget _buildHeader() {
    if (viewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      Strings.signIn,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Center(
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: min(constraints.maxWidth, 600),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 32.0),
              SizedBox(
                height: 50.0,
                child: _buildHeader(),
              ),
              const SizedBox(height: 32.0),
              SignInButton(
                key: emailPasswordButtonKey,
                text: Strings.signInWithEmailPassword,
                onPressed: viewModel.isLoading
                    ? null
                    : () => _showEmailPasswordSignInPage(context),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 8),
              Text(
                Strings.or,
                style: TextStyle(fontSize: 14.0, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              SignInButton(
                key: anonymousButtonKey,
                text: Strings.goAnonymous,
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: viewModel.isLoading
                    ? null
                    : () => _signInAnonymously(context),
              ),
            ],
          ),
        );
      }),
    );
  }
}
