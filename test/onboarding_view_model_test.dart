import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:starter_architecture_flutter_firebase/app/onboarding/onboarding_view_model.dart';
import 'mocks.dart';

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
