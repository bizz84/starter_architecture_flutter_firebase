import 'package:starter_architecture_flutter_firebase/app/sign_in/email_password/email_password_sign_in_page.dart';
import 'package:starter_architecture_flutter_firebase/app/sign_in/sign_in_view_model.dart';
import 'package:starter_architecture_flutter_firebase/app/sign_in/sign_in_button.dart';
import 'package:starter_architecture_flutter_firebase/common_widgets/show_exception_alert_dialog.dart';
import 'package:starter_architecture_flutter_firebase/constants/keys.dart';
import 'package:starter_architecture_flutter_firebase/constants/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:starter_architecture_flutter_firebase/services/firebase_auth_service.dart';

class SignInPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService auth =
        Provider.of<FirebaseAuthService>(context, listen: false);
    return ChangeNotifierProvider<SignInViewModel>(
      create: (_) => SignInViewModel(auth: auth),
      child: Consumer<SignInViewModel>(
        builder: (_, SignInViewModel viewModel, __) => SignInPage._(
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

  Future<void> _showSignInError(
      BuildContext context, PlatformException exception) async {
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
      _showSignInError(context, e);
    }
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
      return Center(
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
    // Make content scrollable so that it fits on small screens
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 32.0),
          SizedBox(
            height: 50.0,
            child: _buildHeader(),
          ),
          SizedBox(height: 32.0),
          SignInButton(
            key: emailPasswordButtonKey,
            text: Strings.signInWithEmailPassword,
            onPressed: viewModel.isLoading
                ? null
                : () => EmailPasswordSignInPageBuilder.show(context),
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(height: 8),
          Text(
            Strings.or,
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          SignInButton(
            key: anonymousButtonKey,
            text: Strings.goAnonymous,
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed:
                viewModel.isLoading ? null : () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }
}
