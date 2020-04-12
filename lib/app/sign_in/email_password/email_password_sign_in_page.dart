import 'package:starter_architecture_flutter_firebase/app/sign_in/email_password/email_password_sign_in_model.dart';
import 'package:starter_architecture_flutter_firebase/common_widgets/form_submit_button.dart';
import 'package:starter_architecture_flutter_firebase/common_widgets/show_alert_dialog.dart';
import 'package:starter_architecture_flutter_firebase/common_widgets/show_exception_alert_dialog.dart';
import 'package:starter_architecture_flutter_firebase/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:starter_architecture_flutter_firebase/routing/router.dart';
import 'package:starter_architecture_flutter_firebase/services/firebase_auth_service.dart';

class EmailPasswordSignInPageBuilder extends StatelessWidget {
  const EmailPasswordSignInPageBuilder({Key key, this.onSignedIn})
      : super(key: key);
  final VoidCallback onSignedIn;

  static Future<void> show(BuildContext context) async {
    final navigator = Navigator.of(context);
    await navigator.pushNamed(
      Routes.emailPasswordSignInPageBuilder,
      arguments: () => navigator.pop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService auth =
        Provider.of<FirebaseAuthService>(context, listen: false);
    return ChangeNotifierProvider<EmailPasswordSignInModel>(
      create: (_) => EmailPasswordSignInModel(auth: auth),
      child: Consumer<EmailPasswordSignInModel>(
        builder: (_, EmailPasswordSignInModel model, __) =>
            EmailPasswordSignInPage(model: model, onSignedIn: onSignedIn),
      ),
    );
  }
}

class EmailPasswordSignInPage extends StatefulWidget {
  const EmailPasswordSignInPage(
      {Key key, @required this.model, this.onSignedIn})
      : super(key: key);
  final EmailPasswordSignInModel model;
  final VoidCallback onSignedIn;

  @override
  _EmailPasswordSignInPageState createState() =>
      _EmailPasswordSignInPageState();
}

class _EmailPasswordSignInPageState extends State<EmailPasswordSignInPage> {
  final FocusScopeNode _node = FocusScopeNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  EmailPasswordSignInModel get model => widget.model;

  @override
  void dispose() {
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showSignInError(EmailPasswordSignInModel model, dynamic exception) {
    showExceptionAlertDialog(
      context: context,
      title: model.errorAlertTitle,
      exception: exception,
    );
  }

  Future<void> _submit() async {
    try {
      final bool success = await model.submit();
      if (success) {
        if (model.formType == EmailPasswordSignInFormType.forgotPassword) {
          await showAlertDialog(
            context: context,
            title: Strings.resetLinkSentTitle,
            content: Strings.resetLinkSentMessage,
            defaultActionText: Strings.ok,
          );
        } else {
          if (widget.onSignedIn != null) {
            widget.onSignedIn();
          }
        }
      }
    } catch (e) {
      _showSignInError(model, e);
    }
  }

  void _emailEditingComplete() {
    if (model.canSubmitEmail) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete() {
    if (!model.canSubmitEmail) {
      _node.previousFocus();
      return;
    }
    _submit();
  }

  void _updateFormType(EmailPasswordSignInFormType formType) {
    model.updateFormType(formType);
    _emailController.clear();
    _passwordController.clear();
  }

  Widget _buildEmailField() {
    return TextField(
      key: Key('email'),
      controller: _emailController,
      decoration: InputDecoration(
        labelText: Strings.emailLabel,
        hintText: Strings.emailHint,
        errorText: model.emailErrorText,
        enabled: !model.isLoading,
      ),
      autocorrect: false,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      keyboardAppearance: Brightness.light,
      onChanged: model.updateEmail,
      onEditingComplete: _emailEditingComplete,
      inputFormatters: <TextInputFormatter>[
        model.emailInputFormatter,
      ],
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      key: Key('password'),
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: model.passwordLabelText,
        errorText: model.passwordErrorText,
        enabled: !model.isLoading,
      ),
      obscureText: true,
      autocorrect: false,
      textInputAction: TextInputAction.done,
      keyboardAppearance: Brightness.light,
      onChanged: model.updatePassword,
      onEditingComplete: _passwordEditingComplete,
    );
  }

  Widget _buildContent() {
    return FocusScope(
      node: _node,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 8.0),
          _buildEmailField(),
          if (model.formType !=
              EmailPasswordSignInFormType.forgotPassword) ...<Widget>[
            SizedBox(height: 8.0),
            _buildPasswordField(),
          ],
          SizedBox(height: 8.0),
          FormSubmitButton(
            key: Key('primary-button'),
            text: model.primaryButtonText,
            loading: model.isLoading,
            onPressed: model.isLoading ? null : _submit,
          ),
          SizedBox(height: 8.0),
          FlatButton(
            key: Key('secondary-button'),
            child: Text(model.secondaryButtonText),
            onPressed: model.isLoading
                ? null
                : () => _updateFormType(model.secondaryActionFormType),
          ),
          if (model.formType == EmailPasswordSignInFormType.signIn)
            FlatButton(
              key: Key('tertiary-button'),
              child: Text(Strings.forgotPasswordQuestion),
              onPressed: model.isLoading
                  ? null
                  : () => _updateFormType(
                      EmailPasswordSignInFormType.forgotPassword),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(model.title),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: _buildContent(),
            ),
          ),
        ),
      ),
    );
  }
}
