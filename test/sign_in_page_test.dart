import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/app/top_level_providers.dart';
import 'package:starter_architecture_flutter_firebase/app/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:starter_architecture_flutter_firebase/routing/app_router.dart';
import 'sign_in_page_test.mocks.dart';

@GenerateMocks([FirebaseAuth, NavigatorObserver])
void main() {
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
            firebaseAuthProvider
                .overrideWithProvider(Provider((ref) => mockFirebaseAuth)),
          ],
          child: Consumer(builder: (context, watch, __) {
            final firebaseAuth = watch(firebaseAuthProvider);
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
      verify(mockNavigatorObserver.didPush(any, any)).called(1);
      // this may not work. See: https://github.com/dart-lang/mockito/blob/master/NULL_SAFETY_README.md#old-missing-stub-behavior
    }

    testWidgets('email & password navigation', (tester) async {
      await pumpSignInPage(tester);

      final emailPasswordButton =
          find.byKey(SignInPageContents.emailPasswordButtonKey);
      expect(emailPasswordButton, findsOneWidget);

      await tester.tap(emailPasswordButton);
      await tester.pumpAndSettle();

      verify(mockNavigatorObserver.didPush(any, any)).called(1);
      // skip until we can make it work: https://github.com/dart-lang/mockito/blob/master/NULL_SAFETY_README.md
    }, skip: true);
  });
}
