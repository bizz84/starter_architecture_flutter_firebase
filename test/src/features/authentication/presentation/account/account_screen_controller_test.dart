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

  group('AccountScreenController', () {
    test('initial state is AsyncValue.data', () {
      final authRepository = MockAuthRepository();
      final container = makeProviderContainer(authRepository);
      final listener = Listener<AsyncValue<void>>();
      container.listen(
        accountScreenControllerProvider,
        listener,
        fireImmediately: true,
      );
      // verify initial value from build method
      verify(() => listener(null, const AsyncData<void>(null)));
      // no more interactions after that
      verifyNoMoreInteractions(listener);
      verifyNever(authRepository.signOut);
    });

    test('signOut success', () async {
      // setup
      final authRepository = MockAuthRepository();
      when(authRepository.signOut).thenAnswer((_) => Future.value());
      final container = makeProviderContainer(authRepository);
      final controller =
          container.read(accountScreenControllerProvider.notifier);
      final listener = Listener<AsyncValue<void>>();
      container.listen(
        accountScreenControllerProvider,
        listener,
        fireImmediately: true,
      );
      // verify initial value from build method
      verify(() => listener(null, const AsyncData<void>(null)));
      // run
      await controller.signOut();
      // verify
      verifyInOrder([
        // set loading state
        () => listener(const AsyncData<void>(null), const AsyncLoading<void>()),
        // data when complete
        () => listener(const AsyncLoading<void>(), const AsyncData<void>(null)),
      ]);
      verifyNoMoreInteractions(listener);
      verify(authRepository.signOut).called(1);
    });
    test('signOut failure', () async {
      // setup
      final authRepository = MockAuthRepository();
      final exception = Exception('Connection failed');
      when(authRepository.signOut).thenThrow(exception);
      final container = makeProviderContainer(authRepository);
      final controller =
          container.read(accountScreenControllerProvider.notifier);
      final listener = Listener<AsyncValue<void>>();
      container.listen(
        accountScreenControllerProvider,
        listener,
        fireImmediately: true,
      );
      // verify initial value from build method
      verify(() => listener(null, const AsyncData<void>(null)));
      // run
      await controller.signOut();
      // verify
      verifyInOrder([
        // set loading state
        () => listener(const AsyncData<void>(null), const AsyncLoading<void>()),
        // error when complete
        () => listener(
              const AsyncLoading<void>(),
              any(that: predicate<AsyncValue<void>>((value) {
                expect(value.hasError, true);
                return true;
              })),
            ),
      ]);
      verifyNoMoreInteractions(listener);
      verify(authRepository.signOut).called(1);
    });
  });
}
