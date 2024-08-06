import 'package:flutter_starter_base_app/src/common_widgets/custom_text_form_field.dart';
import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter_starter_base_app/src/localization/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsernameandPasswordPage extends ConsumerStatefulWidget {
  final GlobalKey<FormState>? formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  UsernameandPasswordPage({
    Key? key,
    this.formKey,
    required this.usernameController,
    required this.passwordController,
    required this.confirmPasswordController,
  }) : super(key: key);

  @override
  _UsernameandPasswordPageState createState() => _UsernameandPasswordPageState();
}

class _UsernameandPasswordPageState extends ConsumerState<UsernameandPasswordPage> {
  FocusNode _usernamefocusNode = FocusNode();
  FocusNode _passwordfocusNode = FocusNode();
  FocusNode _confirmfocusNode = FocusNode();
  ValueNotifier obsecurePassword = ValueNotifier(true);
  ValueNotifier obsecureConfirmPassword = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _usernamefocusNode = FocusNode();
    _passwordfocusNode = FocusNode();
    _confirmfocusNode = FocusNode();
  }

  String? email;

  @override
  void dispose() {
    _usernamefocusNode.dispose();
    _passwordfocusNode.dispose();
    _confirmfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Text(
                  "Create Your Username And Password",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: CustomColors().whitecolor),
                ),
              ),
              textfields(context),

              passwordfield(),
              // Add some spacing between fields
              confirmpasswordfield(),
            ],
          ),
        ),
      ),
    );
  }

  ValueListenableBuilder<dynamic> confirmpasswordfield() {
    return ValueListenableBuilder(
      valueListenable: obsecureConfirmPassword,
      builder: (BuildContext context, value, Widget? child) {
        return CustomTextFormField(
          controller: widget.confirmPasswordController,
          focusNode: _confirmfocusNode,
          textInputType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.account_confPassword.tr(),
                  style: TextStyle(color: CustomColors().whitecolor, fontWeight: FontWeight.w400, fontSize: 17),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Icon(
                  Icons.help,
                  color: CustomColors().whitecolor,
                ),
              ],
            ),
          ),
          hintText: LocaleKeys.hint_password.tr(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter confirm password';
            }
            if (value != widget.passwordController.text) {
              return 'Confirm Password does not match with Password';
            }
            return null;
          },
          // suffixIcon: IconButton(
          //   icon: Icon(
          //     obsecureConfirmPassword.value ? Icons.visibility : Icons.visibility_off,
          //     color: const Color.fromRGBO(208, 188, 255, 1),
          //     size: 20,
          //   ),
          //   onPressed: () {
          //     obsecureConfirmPassword.value = !obsecureConfirmPassword.value;
          //   },
          // ),
         
           maxLines: 1,
           onPressed: () {
              obsecureConfirmPassword.value = !obsecureConfirmPassword.value;
            },
          obscureText: obsecureConfirmPassword.value,
        );
      },
    );
  }

  ValueListenableBuilder<dynamic> passwordfield() {
    return ValueListenableBuilder(
      valueListenable: obsecurePassword,
      builder: (BuildContext context, value, Widget? child) {
        return CustomTextFormField(
          controller: widget.passwordController,
          focusNode: _passwordfocusNode,
          textInputType: TextInputType.text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.common_password.tr(),
                  style: TextStyle(color: CustomColors().whitecolor, fontWeight: FontWeight.w400, fontSize: 17),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Icon(
                  Icons.help,
                  color: CustomColors().whitecolor,
                ),
              ],
            ),
          ),
          hintText: LocaleKeys.hint_password.tr(),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a password';
            }
            // // Password validation rules
            // if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
            //   return 'at least 8 characters, including one uppercase letter, one number, and one special character';
            // }
            return null;
          },
             maxLines: 1,
           onPressed: () {
              obsecurePassword.value = !obsecurePassword.value;
            },
          obscureText: obsecurePassword.value,
        );
      },
    );
  }

  CustomTextFormField textfields(BuildContext context) {
    return CustomTextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.usernameController,
      focusNode: _usernamefocusNode,
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
                  // color: Colors.white,
                  color: CustomColors().whitecolor,
                  fontWeight: FontWeight.w400,
                  fontSize: 17),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Icon(
              Icons.help,
              color: CustomColors().whitecolor,
            )
          ],
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Username  can't be empty";
        }
        // if (value.length < 3) {
        //   return "Username must be at least 3 characters";
        // }
        // if (value.length > 15) {
        //   return "Username can't be more than 15 characters";
        // }
        return null;
      },
     
    );
  }
}
