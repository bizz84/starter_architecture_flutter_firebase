import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter_architecture_flutter_firebase/services/shared_preferences_service.dart';
import 'shared_preferences_service_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  group('SharedPreferencesService', () {
    test('writes to SharedPreferences', () async {
      final preferences = MockSharedPreferences();
      when(preferences.setBool(
              SharedPreferencesService.onboardingCompleteKey, true))
          .thenAnswer((realInvocation) => Future.value(true));
      final service = SharedPreferencesService(preferences);
      await service.setOnboardingComplete();
      verify(preferences.setBool(
          SharedPreferencesService.onboardingCompleteKey, true));
    });

    test('reads from SharedPreferences (null)', () {
      final preferences = MockSharedPreferences();
      when(preferences.getBool(SharedPreferencesService.onboardingCompleteKey))
          .thenReturn(null);
      final service = SharedPreferencesService(preferences);
      expect(service.isOnboardingComplete(), false);
    });
    test('reads from SharedPreferences (false)', () {
      final preferences = MockSharedPreferences();
      when(preferences.getBool(SharedPreferencesService.onboardingCompleteKey))
          .thenReturn(false);
      final service = SharedPreferencesService(preferences);
      expect(service.isOnboardingComplete(), false);
    });
    test('reads from SharedPreferences (true)', () {
      final preferences = MockSharedPreferences();
      when(preferences.getBool(SharedPreferencesService.onboardingCompleteKey))
          .thenReturn(true);
      final service = SharedPreferencesService(preferences);
      expect(service.isOnboardingComplete(), true);
    });
  });
}
