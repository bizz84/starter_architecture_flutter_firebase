import 'package:flutter_starter_base_app/src/common_widgets/primary_button.dart';
import 'package:flutter_starter_base_app/src/constants/colors.dart';
import 'package:flutter_starter_base_app/src/localization/generated/locale_keys.g.dart';
import 'package:flutter_starter_base_app/src/routing/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Container(
          decoration:
              const BoxDecoration(image: DecorationImage(image: AssetImage('assets/splash.jpg'), fit: BoxFit.cover)),
          child: Stack(children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 250,
                    width: double.infinity,
                    color: CustomColors().whitecolor,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                          Image.asset('assets/logo.png'),
                          const SizedBox(height: 20),
                          PrimaryButton(
                              text: LocaleKeys.btn_getStarted.tr(),
                              backgroundColor: CustomColors().lightblueColor,
                              onPressed: () => context.goNamed(AppRoute.setupSecreen.name)),
                          const SizedBox(height: 10),
                          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text('${LocaleKeys.btn_haveAccount.tr()} ',
                                style: TextStyle(
                                    fontSize: 14, color: CustomColors().lightblueColor, fontWeight: FontWeight.bold)),
                            TextButton(
                                onPressed: () => context.pushNamed(AppRoute.signIn.name),
                                child: Text(LocaleKeys.btn_login.tr(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: CustomColors().lightblueColor,
                                        fontWeight: FontWeight.bold)))
                          ]),
                          const SizedBox(height: 10)
                        ]))))
          ])));
}
