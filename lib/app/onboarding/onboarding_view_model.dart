import 'package:flutter_riverpod/all.dart';
import 'package:state_notifier/state_notifier.dart';

final onboardingViewModelProvider = StateNotifierProvider<OnboardingViewModel>(
  (ref) => OnboardingViewModel(),
);

class OnboardingViewModel extends StateNotifier<bool> {
  OnboardingViewModel() : super(false);

  void completeOnboarding() => state = true;

  bool get didCompleteOnboarding => state;
}
