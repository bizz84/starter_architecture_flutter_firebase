import 'package:flutter_starter_base_app/src/common_widgets/action_text_button.dart';
import 'package:flutter_starter_base_app/src/common_widgets/app_bar.dart';
import 'package:flutter_starter_base_app/src/common_widgets/custom_text_form_field.dart';
import 'package:flutter_starter_base_app/src/common_widgets/primary_button.dart';
import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter_starter_base_app/src/features/login/data/providers.dart';
import 'package:flutter_starter_base_app/src/localization/generated/locale_keys.g.dart';
import 'package:flutter_starter_base_app/src/routing/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordView extends ConsumerStatefulWidget {
  const ResetPasswordView({
    super.key,
  });

  @override
  ConsumerState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends ConsumerState<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController verificationCodeController = TextEditingController();
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();
  FocusNode _verificationCodeFocusNode = FocusNode();

  final ValueNotifier<bool> _obscurePassword = ValueNotifier(true);
  final ValueNotifier<bool> _obscureConfirmPassword = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _usernameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    _verificationCodeFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _verificationCodeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleWidget: Text(LocaleKeys.btn_resetPassword.tr()),
        showBackButton: true,
        showHamburgerMenu: false,
      ),
      body: Container(
        color: CustomColors().darkGray,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.5, vertical: 16),
                          child: Text(
                            LocaleKeys.account_reset_checkYourEmailDesc.tr(),
                            style: TextStyle(
                              color: CustomColors().whitecolor,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        textField(
                          context,
                          controller: usernameController,
                          focusNode: _usernameFocusNode,
                          hintText: LocaleKeys.hint_enter.tr(),
                          label: LocaleKeys.common_username.tr(),
                        ),
                        passwordField(
                          context,
                          controller: passwordController,
                          focusNode: _passwordFocusNode,
                          hintText: LocaleKeys.hint_enter.tr(),
                          label: LocaleKeys.common_password.tr(),
                          obscureNotifier: _obscurePassword,
                        ),
                        passwordField(
                          context,
                          controller: confirmPasswordController,
                          focusNode: _confirmPasswordFocusNode,
                          hintText: LocaleKeys.hint_enter.tr(),
                          label: LocaleKeys.account_confPassword.tr(),
                          obscureNotifier: _obscureConfirmPassword,
                          isConfirm: true,
                        ),
                        textField(
                          context,
                          controller: verificationCodeController,
                          focusNode: _verificationCodeFocusNode,
                          hintText: LocaleKeys.hint_enter.tr(),
                          label: LocaleKeys.account_verification.tr(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  PrimaryButton(
                    text: 'Update Password',
                    backgroundColor: CustomColors().lightblueColor,
                    onPressed: () async {
                      try {
                        if (_formKey.currentState!.validate()) {
                          await ref
                              .read(resetPasswordProvider(
                                      username: usernameController.text,
                                      newPassword: passwordController.text,
                                      otp: verificationCodeController.text)
                                  .future)
                              .then((response) {
                            final message = response.message;
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                              context.goNamed(AppRoute.passwordSuccess.name);
                            }
                          });
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to reset password: $e')),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  ActionTextButton(onPressed: () => context.canPop() ? context.pop() : null, text: 'Cancel'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  CustomTextFormField textField(
    BuildContext context, {
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    required String label,
  }) {
    return CustomTextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      focusNode: focusNode,
      textInputType: TextInputType.text,
      hintText: hintText,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
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
          return "$label can't be empty";
        }
        if (label == "Username") {
          if (value.length < 3) {
            return "Username must be at least 3 characters";
          }
          if (value.length > 15) {
            return "Username can't be more than 15 characters";
          }
        }
        return null;
      },
    );
  }

  ValueListenableBuilder<bool> passwordField(
    BuildContext context, {
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    required String label,
    required ValueNotifier<bool> obscureNotifier,
    bool isConfirm = false,
  }) {
    return ValueListenableBuilder(
      valueListenable: obscureNotifier,
      builder: (context, value, child) {
        return CustomTextFormField(
          controller: controller,
          focusNode: focusNode,
          textInputType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
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
          hintText: hintText,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label is required';
            }
            if (!isConfirm) {
              if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
                return 'At least 8 characters, including one uppercase letter, one number, and one special character';
              }
            } else {
              if (value != passwordController.text) {
                return 'Passwords do not match';
              }
            }
            return null;
          },
        );
      },
    );
  }
}
