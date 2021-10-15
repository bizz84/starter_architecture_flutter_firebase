import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/app/top_level_providers.dart';
import 'package:starter_architecture_flutter_firebase/app/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_architecture_flutter_firebase/routing/app_router.dart';
import 'mocks.dart';

void main() {
  setUpAll(() {
    registerFallbackValue<Route<dynamic>>(
        MaterialPageRoute(builder: (_) => Container()));
  });

  group('sign-in page', () {
    late MockFirebaseAuth mockFirebaseAuth;
    late MockNavigatorObserver mockNavigatorObserver;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockNavigatorObserver = MockNavigatorObserver();
    });

    Future<void> pumpSignInPage(WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            firebaseAuthProvider.overrideWithValue(mockFirebaseAuth),
          ],
          child: Consumer(builder: (context, ref, __) {
            final firebaseAuth = ref.watch(firebaseAuthProvider);
            return MaterialApp(
              home: SignInPage(),
              onGenerateRoute: (settings) =>
                  AppRouter.onGenerateRoute(settings, firebaseAuth),
              navigatorObservers: [mockNavigatorObserver],
            );
          }),
        ),
      );
      // didPush is called once when the widget is first built
      verify(() => mockNavigatorObserver.didPush(any(), any())).called(1);
    }

    testWidgets('email & password navigation', (tester) async {
      await pumpSignInPage(tester);

      final emailPasswordButton =
          find.byKey(SignInPageContents.emailPasswordButtonKey);
      expect(emailPasswordButton, findsOneWidget);

      await tester.tap(emailPasswordButton);
      await tester.pumpAndSettle();

      verify(() => mockNavigatorObserver.didPush(captureAny(), captureAny()))
          .called(1);
    });
  });
}
