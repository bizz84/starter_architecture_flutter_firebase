@Timeout(Duration(milliseconds: 500))
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/presentation/account/account_screen_controller.dart';

import '../../../../mocks.dart';

void main() {
  ProviderContainer makeProviderContainer(MockAuthRepository authRepository) {
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(authRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUpAll(() {
    registerFallbackValue(const AsyncLoading<int>());
  });

  group('AccountScreenController', () {
    test('initial state is AsyncData', () {
      final authRepository = MockAuthRepository();
      // create the ProviderContainer with the mock auth repository
      final container = makeProviderContainer(authRepository);
      // create a listener
      final listener = Listener<AsyncValue<void>>();
      // listen to the provider and call [listener] whenever its value changes
      container.listen(
        accountScreenControllerProvider,
        listener,
        fireImmediately: true,
      );
      // verify
      verify(
        // the build method returns a value immediately, so we expect AsyncData
        () => listener(null, const AsyncData<void>(null)),
      );
      // verify that the listener is no longer called
      verifyNoMoreInteractions(listener);
      // verify that [signInAnonymously] was not called during initialization
      verifyNever(authRepository.signOut);
    });

    test('signOut success', () async {
      // setup
      final authRepository = MockAuthRepository();
      // stub method to return success
      when(authRepository.signOut).thenAnswer((_) => Future.value());
      // create the ProviderContainer with the mock auth repository
      final container = makeProviderContainer(authRepository);
      // create a listener
      final listener = Listener<AsyncValue<void>>();
      // listen to the provider and call [listener] whenever its value changes
      container.listen(
        accountScreenControllerProvider,
        listener,
        fireImmediately: true,
      );
      // sto
      const data = AsyncData<void>(null);
      // verify initial value from build method
      verify(() => listener(null, data));
      // run
      final controller =
          container.read(accountScreenControllerProvider.notifier);
      await controller.signOut();
      // verify
      verifyInOrder([
        // set loading state
        // * use a matcher since AsyncLoading != AsyncLoading with data
        // * https://codewithandrea.com/articles/unit-test-async-notifier-riverpod/
        () => listener(data, any(that: isA<AsyncLoading>())),
        // data when complete
        () => listener(any(that: isA<AsyncLoading>()), data),
      ]);
      verifyNoMoreInteractions(listener);
      verify(authRepository.signOut).called(1);
    });
    test('signOut failure', () async {
      // setup
      final authRepository = MockAuthRepository();
      // stub method to return success
      final exception = Exception('Connection failed');
      when(authRepository.signOut).thenThrow(exception);
      // create the ProviderContainer with the mock auth repository
      final container = makeProviderContainer(authRepository);
      // create a listener
      final listener = Listener<AsyncValue<void>>();
      // listen to the provider and call [listener] whenever its value changes
      container.listen(
        accountScreenControllerProvider,
        listener,
        fireImmediately: true,
      );
      const data = AsyncData<void>(null);
      // verify initial value from build method
      verify(() => listener(null, data));
      // run
      final controller =
          container.read(accountScreenControllerProvider.notifier);
      await controller.signOut();
      // verify
      verifyInOrder([
        // set loading state
        // * use a matcher since AsyncLoading != AsyncLoading with data
        () => listener(data, any(that: isA<AsyncLoading>())),
        // error when complete
        () => listener(
            any(that: isA<AsyncLoading>()), any(that: isA<AsyncError>())),
      ]);
      verifyNoMoreInteractions(listener);
      verify(authRepository.signOut).called(1);
    });
  });
}
