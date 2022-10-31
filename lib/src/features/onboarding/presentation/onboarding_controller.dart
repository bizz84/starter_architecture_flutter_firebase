import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/src/features/onboarding/data/onboarding_repository.dart';

class OnboardingController extends StateNotifier<bool> {
  OnboardingController(this.sharedPreferencesService)
      : super(sharedPreferencesService.isOnboardingComplete());
  final OnboardingRepository sharedPreferencesService;

  Future<void> completeOnboarding() async {
    await sharedPreferencesService.setOnboardingComplete();
    state = true;
  }

  bool get isOnboardingComplete => state;
}

final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, bool>((ref) {
  final sharedPreferencesService = ref.watch(onboardingRepositoryProvider);
  return OnboardingController(sharedPreferencesService);
});
