import 'package:flutter_starter_base_app/src/common_widgets/app_bar.dart';
import 'package:flutter_starter_base_app/src/common_widgets/primary_button.dart';
import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter_starter_base_app/src/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PasswordUpdateSuccessView extends ConsumerStatefulWidget {
  const PasswordUpdateSuccessView({super.key});

  @override
  ConsumerState createState() => _PasswordUpdateSuccessViewState();
}

class _PasswordUpdateSuccessViewState extends ConsumerState<PasswordUpdateSuccessView> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: const CustomAppBar(
          titleWidget: Text('Reset Password Success'), showBackButton: false, showHamburgerMenu: false),
      body: Container(
          color: CustomColors().darkGray,
          child: Column(children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17.5, vertical: 16),
                    child: Text('Your password was updated. Please log in with your new password.',
                        style:
                            TextStyle(color: CustomColors().whitecolor, fontSize: 17, fontWeight: FontWeight.w400)))),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  PrimaryButton(
                      text: 'Go To Log In Page',
                      backgroundColor: CustomColors().lightblueColor,
                      onPressed: () => context.mounted ? context.goNamed(AppRoute.signIn.name) : null)
                ]))
          ])));
}
