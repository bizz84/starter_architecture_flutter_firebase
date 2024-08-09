import 'package:flutter_starter_base_app/src/common_widgets/basic_page_importer.dart';
import 'package:flutter_starter_base_app/src/common_widgets/country_select/presentation/country_select.dart';
import 'package:flutter_starter_base_app/src/common_widgets/state_select/presentation/state_select.dart';
import 'package:flutter_starter_base_app/src/features/account/presentation/eula_transition.dart';
import 'package:flutter_starter_base_app/src/features/account/presentation/eula_view.dart';
import 'package:flutter_starter_base_app/src/features/login/presentation/check_eula.dart';
import 'package:flutter_starter_base_app/src/features/login/presentation/forgot_password_page.dart';
import 'package:flutter_starter_base_app/src/features/login/presentation/login_page.dart';
import 'package:flutter_starter_base_app/src/features/login/presentation/login_transition.dart';
import 'package:flutter_starter_base_app/src/features/login/presentation/logout_transition.dart';
import 'package:flutter_starter_base_app/src/features/login/presentation/reset_password_page.dart';
import 'package:flutter_starter_base_app/src/features/login/presentation/reset_password_success_page.dart';
import 'package:flutter_starter_base_app/src/features/login/presentation/startup.dart';
import 'package:flutter_starter_base_app/src/features/onboarding/presentation/splash.dart';
import 'package:flutter_starter_base_app/src/features/report/presentation/report_table_page.dart';
import 'package:flutter_starter_base_app/src/features/report/presentation/reports_page.dart';
import 'package:flutter_starter_base_app/src/root/domain/item.dart';
import 'package:flutter_starter_base_app/src/root/presentation/accounts_page.dart';
import 'package:flutter_starter_base_app/src/root/presentation/setup_screen.dart';
import 'package:flutter_starter_base_app/src/root/presentation/setup_success_page.dart';
import 'package:flutter_starter_base_app/src/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'app_router.g.dart';

final currentMainRouteIndexProvider = StateProvider<int>((ref) => 0);
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'nav');

List<AppRoute> get bottomNavRoutes => [AppRoute.home, AppRoute.account, AppRoute.reports];

/// todo meta objects can be serialized
final routes = <RouteBase>[
  GoRoute(name: AppRoute.start.name, path: '/${AppRoute.start.name}', builder: (context, state) => const Startup()),
  GoRoute(
      name: AppRoute.splash.name, path: '/${AppRoute.splash.name}', builder: (context, state) => const SplashView()),
  GoRoute(name: AppRoute.signIn.name, path: '/${AppRoute.signIn.name}', builder: (context, state) => const LoginPage()),
  GoRoute(
      name: AppRoute.checkEULA.name,
      path: '/${AppRoute.checkEULA.name}',
      builder: (context, state) => const CheckEULA()),
  GoRoute(
      name: AppRoute.resetPassword.name,
      path: '/${AppRoute.resetPassword.name}',
      builder: (context, state) => const ResetPasswordView()),
  GoRoute(
      name: AppRoute.passwordSuccess.name,
      path: '/${AppRoute.passwordSuccess.name}',
      builder: (context, state) => const PasswordUpdateSuccessView()),
  GoRoute(
      name: AppRoute.setupSecreen.name,
      path: '/${AppRoute.setupSecreen.name}',
      builder: (context, state) => const SetupScreen()),
  GoRoute(
      name: AppRoute.logoutPageTransition.name,
      path: '/${AppRoute.logoutPageTransition.name}',
      builder: (context, state) => const LogoutPageTransition()),
  GoRoute(
      name: AppRoute.loginPageTransition.name,
      path: '/${AppRoute.loginPageTransition.name}/:username/:password',
      builder: (context, state) => LoginPageTransition(
          username: state.pathParameters['username'] ?? '', password: state.pathParameters['password'] ?? '')),
  GoRoute(
      name: AppRoute.acceptEULA.name,
      path: '/${AppRoute.acceptEULA.name}',
      builder: (context, state) => EulaView(isCancellable: false, onEULAAccepted: (bool acceptEULA) {})),
  GoRoute(
      name: AppRoute.eulaTransition.name,
      path: '/${AppRoute.eulaTransition.name}',
      builder: (context, state) => const EULATransition()),
  GoRoute(
      name: AppRoute.setupComplete.name,
      path: '/${AppRoute.setupComplete.name}',
      builder: (context, state) => const SetupCompletePage()),
  GoRoute(
      name: AppRoute.forgotPassword.name,
      path: '/${AppRoute.forgotPassword.name}',
      builder: (context, state) => const ForgotPasswordView()),
  GoRoute(
    name: AppRoute.stateChooser.name,
    path: "/${AppRoute.stateChooser.name}",
    parentNavigatorKey: _rootNavigatorKey,
    builder: (context, state) {
      final extras = state.extra as Map<String, dynamic>;
      return StateSelect(
          countryName: extras['countryName'] as String,
          initialSelection: extras['initialSelection'] as Item?);
    },
  ),
  GoRoute(
    name: AppRoute.countryChooser.name,
    path: "/${AppRoute.countryChooser.name}",
    parentNavigatorKey: _rootNavigatorKey,
    builder: (context, state) {
      final extras = state.extra as Map<String, dynamic>?;
      return CountrySelect(initialSelection: extras?['initialSelection'] as Item<dynamic>?);
    },
  ),
  ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => CustomNavigationBar(child: child),
      routes: [
        GoRoute(
            name: AppRoute.account.name,
            path: '/${AppRoute.account.name}',
            builder: (context, state) => const AccountDetailsPage(),
            routes: [
            ]),
        GoRoute(
            name: AppRoute.reports.name,
            path: '/${AppRoute.reports.name}',
            builder: (context, state) => const ReportsPage(),
            routes: [
              GoRoute(
                  name: AppRoute.reportTable.name,
                  path: AppRoute.reportTable.name,
                  builder: (context, state) => const ReportTablePage()),
            ])
      ]),
];

@riverpod
GoRouter goRouter(GoRouterRef ref) => GoRouter(debugLogDiagnostics: true, navigatorKey: _rootNavigatorKey, initialLocation: '/start', routes: routes);
