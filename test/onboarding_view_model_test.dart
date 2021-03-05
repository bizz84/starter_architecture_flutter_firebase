import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:starter_architecture_flutter_firebase/app/onboarding/onboarding_view_model.dart';
import 'package:starter_architecture_flutter_firebase/services/shared_preferences_service.dart';

import 'onboarding_view_model_test.mocks.dart';

@GenerateMocks([SharedPreferencesService])
void main() {
  group('OnboardingViewModel', () {
    test('OnboardingViewModel loads state from service', () {
      final mockService = MockSharedPreferencesService();
      when(mockService.isOnboardingComplete()).thenReturn(true);
      final vm = OnboardingViewModel(mockService);
      expect(vm.isOnboardingComplete, true);
    });

    test('OnboardingViewModel.completeOnboarding() sets state', () async {
      final mockService = MockSharedPreferencesService();
      when(mockService.isOnboardingComplete()).thenReturn(false);
      final vm = OnboardingViewModel(mockService);
      await vm.completeOnboarding();
      expect(vm.isOnboardingComplete, true);
      verify(mockService.setOnboardingComplete()).called(1);
    });
  });
}
