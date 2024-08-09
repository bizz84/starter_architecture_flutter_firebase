import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter_starter_base_app/src/common_widgets/primary_button.dart';
import 'package:flutter_starter_base_app/src/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SetupCompletePage extends StatelessWidget {
  const SetupCompletePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 18),
                Text('Setup',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w400, color: CustomColors().whitecolor),
                    textAlign: TextAlign.center),
                const SizedBox(height: 16),
                Text('Congratulations!',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, color: CustomColors().whitecolor),
                    textAlign: TextAlign.center),
                const SizedBox(height: 16),
                Image.asset('assets/group.png'),
                const SizedBox(height: 16),
                Text('Your initial setup is complete.',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: CustomColors().whitecolor),
                    textAlign: TextAlign.center),
                const Spacer(),
                PrimaryButton(
                    text: 'Go To App Home',
                    backgroundColor: CustomColors().lightblueColor,
                    onPressed: () => context.goNamed(AppRoute.home.name))
              ])));
}
