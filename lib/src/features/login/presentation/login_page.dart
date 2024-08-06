import 'package:flutter_starter_base_app/src/common_widgets/action_text_button.dart';
import 'package:flutter_starter_base_app/src/common_widgets/app_bar.dart';
import 'package:flutter_starter_base_app/src/common_widgets/custom_text_form_field.dart';
import 'package:flutter_starter_base_app/src/common_widgets/primary_button.dart';
import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter_starter_base_app/src/localization/generated/locale_keys.g.dart';
import 'package:flutter_starter_base_app/src/routing/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui' as ui;
import 'package:go_router/go_router.dart';

///XXX: only for testing
const String username = String.fromEnvironment('USERNAME');
const String password = String.fromEnvironment('PASSWORD');

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController(text: username);
  final TextEditingController passwordController = TextEditingController(text: password);
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  ValueNotifier obsecurePassword = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: CustomAppBar(
        titleWidget: Text(LocaleKeys.btn_login.tr()),
        leading: _buildAppbarBack(context),
        showHamburgerMenu: false,
      ),
      body: Container(
          color: CustomColors().darkGray,
          child: Form(
              key: _formKey,
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [_buildEmailField(context), _buildPasswordField()]),
                    Column(children: [
                      _buildLogin(context),
                      ActionTextButton(
                          text: LocaleKeys.btn_forgotPassword.tr(),
                          onPressed: () => context.pushNamed(AppRoute.forgotPassword.name))
                    ])
                  ])))));

  _buildAppbarBack(BuildContext context) {
    return InkWell(
        onTap: () => context.goNamed(AppRoute.splash.name),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Icon(CupertinoIcons.back),
          Text(LocaleKeys.common_back.tr(),
              style: TextStyle(
                color: CustomColors().primaryTextColor,
                fontSize: 17,
              ))
        ]));
  }

  _buildLogin(BuildContext context) => PrimaryButton(
      text: LocaleKeys.btn_login.tr(),
      backgroundColor: CustomColors().lightblueColor,
      onPressed: () => _formKey.currentState!.validate()
          ? context.pushNamed(AppRoute.loginPageTransition.name,
              pathParameters: {'password': passwordController.text, 'username': usernameController.text})
          : null);

  _buildPasswordField() {
    return ValueListenableBuilder(
        valueListenable: obsecurePassword,
        builder: (context, value, child) {
          return TextFormField(
            controller: passwordController,
            focusNode: _passwordFocusNode,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.right,
            maxLines: 1,
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: CustomColors().whitecolor,
            ),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(12.0),
                hintMaxLines: 1,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    borderSide: BorderSide(
                      color: CustomColors().grayColor,
                    )),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColors().grayColor, width: 0),
                  borderRadius: BorderRadius.circular(0.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColors().grayColor, width: 0),
                  borderRadius: BorderRadius.circular(0.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  borderSide: BorderSide(
                    color: CustomColors().red,
                    width: 1,
                  ),
                ),
                errorStyle: TextStyle(color: CustomColors().red),
                hintTextDirection: ui.TextDirection.rtl,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelStyle:
                    TextStyle(color: CustomColors().lightblueColor, fontSize: 17, fontWeight: FontWeight.normal),
                fillColor: CustomColors().grayColor,
                filled: true,
                hintText: LocaleKeys.hint_password.tr(),
                hintStyle: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: CustomColors().lightblueColor,
                    fontSize: 17,
                    fontWeight: FontWeight.normal),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        LocaleKeys.common_password.tr(),
                        style: TextStyle(
                          color: CustomColors().whitecolor,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Icon(
                        Icons.help,
                        color: CustomColors().lightblueColor,
                        size: 15,
                      ),
                    ],
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 30,
                  minHeight: 30,
                )),
            obscureText: obsecurePassword.value,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a password';
              }
              // if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
              //   return 'At least 8 characters, including one uppercase letter, one number, and one special character';
              // }
              return null;
            },
          );
        });
  }

  _buildEmailField(BuildContext context) {
    return CustomTextFormField(
      controller: usernameController,
      focusNode: _usernameFocusNode,
      textInputType: TextInputType.emailAddress,
      hintText: LocaleKeys.hint_emailOrUsername.tr(),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.common_username.tr(),
              style: TextStyle(
                color: CustomColors().whitecolor,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Icon(
              Icons.help,
              color: CustomColors().lightblueColor,
              size: 15,
            ),
          ],
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Username can't be empty";
        }
        if (value.length < 3) {
          return "Username must be at least 3 characters";
        }
        if (value.length > 25) {
          return "Username can't be more than 15 characters";
        }
        return null;
      },
    );
  }
}
