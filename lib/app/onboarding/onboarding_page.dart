import 'package:custom_buttons/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:starter_architecture_flutter_firebase/app/onboarding/onboarding_view_model.dart';

class OnboardingPage extends StatelessWidget {
  Future<void> onGetStarted(BuildContext context) async {
    final onboardingViewModel = context.read(onboardingViewModelProvider);
    await onboardingViewModel.completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Find it, love it, buy it.\nA fresh approach to shopping.',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.center,
            ),
            Container(
              padding: const EdgeInsets.only(top: 80.0, bottom: 80),
              child: SizedBox(
                  // width: 125.0,
                  height: 250.0,
                  child: SvgPicture.asset(
                    'assets/store.svg',
                  )),
            ),
            CustomRaisedButton(
              onPressed: () => onGetStarted(context),
              color: Colors.red,
              borderRadius: 30,
              child: Text(
                'Get Started',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
