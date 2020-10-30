import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/services/shared_preferences_service.dart';
import 'package:state_notifier/state_notifier.dart';

final onboardingViewModelProvider = StateNotifierProvider<OnboardingViewModel>(
  (ref) => OnboardingViewModel(ref),
);

class OnboardingViewModel extends StateNotifier<bool> {
  OnboardingViewModel(this.ref) : super(false) {
    init();
  }
  final ProviderReference ref;

  Future<void> init() async {
    final sharedPreferencesService =
        await ref.read(sharedPreferencesServiceProvider.future);
    state = sharedPreferencesService.isOnboardingComplete();
  }

  Future<void> completeOnboarding() async {
    final sharedPreferencesService =
        await ref.read(sharedPreferencesServiceProvider.future);
    await sharedPreferencesService.setOnboardingComplete();
    state = true;
  }
}
