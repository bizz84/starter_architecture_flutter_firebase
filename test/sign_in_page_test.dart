import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:starter_architecture_flutter_firebase/app/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:starter_architecture_flutter_firebase/routing/app_router.dart';

import 'mocks.dart';

void main() {
  group('sign-in page', () {
    MockAuthService mockAuthService;
    MockNavigatorObserver mockNavigatorObserver;
    StreamController<User> onAuthStateChangedController;

    setUp(() {
      mockAuthService = MockAuthService();
      mockNavigatorObserver = MockNavigatorObserver();
      onAuthStateChangedController = StreamController<User>();
    });

    tearDown(() {
      onAuthStateChangedController.close();
    });

    Future<void> pumpSignInPage(WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            Provider<FirebaseAuth>(
              create: (_) => mockAuthService,
            ),
          ],
          child: MaterialApp(
            home: SignInPageBuilder(),
            onGenerateRoute: AppRouter.onGenerateRoute,
            navigatorObservers: [mockNavigatorObserver],
          ),
        ),
      );
      // didPush is called once when the widget is first built
      verify(mockNavigatorObserver.didPush(any, any)).called(1);
    }

    testWidgets('email & password navigation', (tester) async {
      await pumpSignInPage(tester);

      final emailPasswordButton = find.byKey(SignInPage.emailPasswordButtonKey);
      expect(emailPasswordButton, findsOneWidget);

      await tester.tap(emailPasswordButton);
      await tester.pumpAndSettle();

      verify(mockNavigatorObserver.didPush(any, any)).called(1);
    }, skip: true);
  });
}
