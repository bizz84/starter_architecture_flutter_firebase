import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_repository.g.dart';

class OnboardingRepository {
  OnboardingRepository(this.sharedPreferences);
  final SharedPreferences sharedPreferences;

  static const onboardingCompleteKey = 'onboardingComplete';

  Future<void> setOnboardingComplete() async {
    await sharedPreferences.setBool(onboardingCompleteKey, true);
  }

  bool isOnboardingComplete() =>
      sharedPreferences.getBool(onboardingCompleteKey) ?? false;
}

@Riverpod(keepAlive: true)
OnboardingRepository onboardingRepository(OnboardingRepositoryRef ref) {
  throw UnimplementedError();
}
