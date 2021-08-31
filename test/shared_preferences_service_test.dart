import 'package:flutter_test/flutter_test.dart';
import 'package:starter_architecture_flutter_firebase/services/shared_preferences_service.dart';
import 'package:mocktail/mocktail.dart';
import 'mocks.dart';

void main() {
  group('SharedPreferencesService', () {
    test('writes to SharedPreferences', () async {
      final preferences = MockSharedPreferences();
      when(() => preferences.setBool(
              SharedPreferencesService.onboardingCompleteKey, true))
          .thenAnswer((_) => Future.value(true));
      final service = SharedPreferencesService(preferences);
      await service.setOnboardingComplete();
      verify(() => preferences.setBool(
          SharedPreferencesService.onboardingCompleteKey, true));
    });

    test('reads from SharedPreferences (null)', () {
      final preferences = MockSharedPreferences();
      when(() => preferences.getBool(
          SharedPreferencesService.onboardingCompleteKey)).thenReturn(null);
      final service = SharedPreferencesService(preferences);
      expect(service.isOnboardingComplete(), false);
    });
    test('reads from SharedPreferences (false)', () {
      final preferences = MockSharedPreferences();
      when(() => preferences.getBool(
          SharedPreferencesService.onboardingCompleteKey)).thenReturn(false);
      final service = SharedPreferencesService(preferences);
      expect(service.isOnboardingComplete(), false);
    });
    test('reads from SharedPreferences (true)', () {
      final preferences = MockSharedPreferences();
      when(() => preferences.getBool(
          SharedPreferencesService.onboardingCompleteKey)).thenReturn(true);
      final service = SharedPreferencesService(preferences);
      expect(service.isOnboardingComplete(), true);
    });
  });
}
