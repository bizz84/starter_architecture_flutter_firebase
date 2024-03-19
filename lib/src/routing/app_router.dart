import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter_architecture_flutter_firebase/src/routing/app_startup.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/presentation/custom_profile_screen.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/presentation/custom_sign_in_screen.dart';
import 'package:starter_architecture_flutter_firebase/src/features/entries/presentation/entries_screen.dart';
import 'package:starter_architecture_flutter_firebase/src/features/entries/domain/entry.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/domain/job.dart';
import 'package:starter_architecture_flutter_firebase/src/features/entries/presentation/entry_screen/entry_screen.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/presentation/job_entries_screen/job_entries_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/presentation/edit_job_screen/edit_job_screen.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/presentation/jobs_screen/jobs_screen.dart';
import 'package:starter_architecture_flutter_firebase/src/features/onboarding/data/onboarding_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:starter_architecture_flutter_firebase/src/routing/go_router_refresh_stream.dart';
import 'package:starter_architecture_flutter_firebase/src/routing/not_found_screen.dart';
import 'package:starter_architecture_flutter_firebase/src/routing/scaffold_with_nested_navigation.dart';

part 'app_router.g.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _jobsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'jobs');
final _entriesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'entries');
final _accountNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'account');

enum AppRoute {
  onboarding,
  signIn,
  jobs,
  job,
  addJob,
  editJob,
  entry,
  addEntry,
  editEntry,
  entries,
  profile,
}

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  // rebuild GoRouter when app startup state changes
  final appStartupState = ref.watch(appStartupProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/signIn',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // If the app is still initializing, show the /startup route
      if (appStartupState.isLoading || appStartupState.hasError) {
        return '/startup';
      }
      final onboardingRepository =
          ref.read(onboardingRepositoryProvider).requireValue;
      final didCompleteOnboarding = onboardingRepository.isOnboardingComplete();
      final path = state.uri.path;
      if (!didCompleteOnboarding) {
        // Always check state.subloc before returning a non-null route
        // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart#L78
        if (path != '/onboarding') {
          return '/onboarding';
        }
        return null;
      }
      final isLoggedIn = authRepository.currentUser != null;
      if (isLoggedIn) {
        if (path.startsWith('/startup') ||
            path.startsWith('/onboarding') ||
            path.startsWith('/signIn')) {
          return '/jobs';
        }
      } else {
        if (path.startsWith('/startup') ||
            path.startsWith('/onboarding') ||
            path.startsWith('/jobs') ||
            path.startsWith('/entries') ||
            path.startsWith('/account')) {
          return '/signIn';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/startup',
        pageBuilder: (context, state) => NoTransitionPage(
          child: AppStartupWidget(
            // * This is just a placeholder
            // * The loaded route will be managed by GoRouter on state change
            onLoaded: (_) => const SizedBox.shrink(),
          ),
        ),
      ),
      GoRoute(
        path: '/onboarding',
        name: AppRoute.onboarding.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: CustomSignInScreen(),
        ),
      ),
      // Stateful navigation based on:
      // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) => NoTransitionPage(
          child: ScaffoldWithNestedNavigation(navigationShell: navigationShell),
        ),
        branches: [
          StatefulShellBranch(
            navigatorKey: _jobsNavigatorKey,
            routes: [
              GoRoute(
                path: '/jobs',
                name: AppRoute.jobs.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: JobsScreen(),
                ),
                routes: [
                  GoRoute(
                    path: 'add',
                    name: AppRoute.addJob.name,
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) {
                      return const MaterialPage(
                        fullscreenDialog: true,
                        child: EditJobScreen(),
                      );
                    },
                  ),
                  GoRoute(
                    path: ':id',
                    name: AppRoute.job.name,
                    pageBuilder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return MaterialPage(
                        child: JobEntriesScreen(jobId: id),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'entries/add',
                        name: AppRoute.addEntry.name,
                        parentNavigatorKey: _rootNavigatorKey,
                        pageBuilder: (context, state) {
                          final jobId = state.pathParameters['id']!;
                          return MaterialPage(
                            fullscreenDialog: true,
                            child: EntryScreen(
                              jobId: jobId,
                            ),
                          );
                        },
                      ),
                      GoRoute(
                        path: 'entries/:eid',
                        name: AppRoute.entry.name,
                        pageBuilder: (context, state) {
                          final jobId = state.pathParameters['id']!;
                          final entryId = state.pathParameters['eid']!;
                          final entry = state.extra as Entry?;
                          return MaterialPage(
                            child: EntryScreen(
                              jobId: jobId,
                              entryId: entryId,
                              entry: entry,
                            ),
                          );
                        },
                      ),
                      GoRoute(
                        path: 'edit',
                        name: AppRoute.editJob.name,
                        pageBuilder: (context, state) {
                          final jobId = state.pathParameters['id'];
                          final job = state.extra as Job?;
                          return MaterialPage(
                            fullscreenDialog: true,
                            child: EditJobScreen(jobId: jobId, job: job),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _entriesNavigatorKey,
            routes: [
              GoRoute(
                path: '/entries',
                name: AppRoute.entries.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: EntriesScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _accountNavigatorKey,
            routes: [
              GoRoute(
                path: '/account',
                name: AppRoute.profile.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CustomProfileScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => const NoTransitionPage(
      child: NotFoundScreen(),
    ),
  );
}
