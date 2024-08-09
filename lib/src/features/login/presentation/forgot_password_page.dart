import 'package:flutter_starter_base_app/src/common_widgets/action_text_button.dart';
import 'package:flutter_starter_base_app/src/common_widgets/app_bar.dart';
import 'package:flutter_starter_base_app/src/features/login/data/providers.dart';
import 'package:flutter_starter_base_app/src/localization/generated/locale_keys.g.dart';
import 'package:flutter_starter_base_app/src/routing/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter_starter_base_app/src/common_widgets/custom_text_form_field.dart';
import 'package:flutter_starter_base_app/src/common_widgets/primary_button.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordView extends ConsumerStatefulWidget {
  const ForgotPasswordView({super.key});
  @override
  ConsumerState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final FocusNode _usernameFocusNode = FocusNode();
  @override
  void dispose() {
    _usernameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: CustomAppBar(
          titleWidget: Text(LocaleKeys.btn_forgotPassword.tr()), showBackButton: true, showHamburgerMenu: false),
      body: Container(
          color: CustomColors().darkGray,
          child: Form(
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Column(children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.5, vertical: 16),
                          child: Text(LocaleKeys.account_reset_forgotPassDesc.tr(),
                              style: TextStyle(
                                  color: CustomColors().whitecolor, fontSize: 17, fontWeight: FontWeight.w400))),
                      _buildUsername(context)
                    ]),
                    Column(children: [
                      _buildResetPassword(context),
                      ActionTextButton(
                          onPressed: () => context.canPop() ? context.pop() : null, text: LocaleKeys.btn_login.tr())
                    ])
                  ])))));

  _buildResetPassword(BuildContext context) => PrimaryButton(
      text: LocaleKeys.btn_resetPassword.tr(),
      backgroundColor: CustomColors().lightblueColor,
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          try {
            await ref.read(forgotPasswordProvider(username: usernameController.text).future).then((response) {
              final message = response.message;
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
              }
            });
            if (context.mounted) context.pushNamed(AppRoute.resetPassword.name);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
          }
        }
      });

  _buildUsername(BuildContext context) => CustomTextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: usernameController,
      focusNode: _usernameFocusNode,
      textInputType: TextInputType.text,
      hintText: 'Enter Username',
      prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 10),
          child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(LocaleKeys.common_username.tr(),
                style: TextStyle(color: CustomColors().whitecolor, fontWeight: FontWeight.w400, fontSize: 17)),
            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
            Icon(Icons.help, color: CustomColors().lightblueColor, size: 15)
          ])),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Username can't be empty";
        }
        if (value.length < 3) {
          return "Username must be at least 3 characters";
        }
        if (value.length > 50) {
          return "Username can't be more than 50 characters";
        }
        return null;
      });
}
