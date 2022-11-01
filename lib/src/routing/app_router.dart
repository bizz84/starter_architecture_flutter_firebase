import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/presentation/account/account_screen.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/presentation/email_password/email_password_sign_in_form_type.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/presentation/email_password/email_password_sign_in_screen.dart';
import 'package:starter_architecture_flutter_firebase/src/features/authentication/presentation/sign_in/sign_in_screen.dart';
import 'package:starter_architecture_flutter_firebase/src/features/entries/entries_page.dart';
import 'package:starter_architecture_flutter_firebase/src/features/home/models/entry.dart';
import 'package:starter_architecture_flutter_firebase/src/features/home/models/job.dart';
import 'package:starter_architecture_flutter_firebase/src/features/job_entries/entry_page.dart';
import 'package:starter_architecture_flutter_firebase/src/features/job_entries/job_entries_page.dart';
import 'package:go_router/go_router.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/edit_job_page.dart';
import 'package:starter_architecture_flutter_firebase/src/features/jobs/jobs_page.dart';
import 'package:starter_architecture_flutter_firebase/src/routing/go_router_refresh_stream.dart';
import 'package:starter_architecture_flutter_firebase/src/routing/scaffold_with_bottom_nav_bar.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  signIn,
  emailPassword,
  jobs,
  job,
  addJob,
  editJob,
  entry,
  addEntry,
  editEntry,
  entries,
  account,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/signIn',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      if (isLoggedIn) {
        if (state.location == '/signIn') {
          return '/jobs';
        }
      } else {
        // TODO
        if (state.location == '/account' || state.location == '/orders') {
          return '/signIn';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      // TODO: Onboarding
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SignInScreen(),
        ),
        routes: [
          GoRoute(
            path: 'emailPassword',
            name: AppRoute.emailPassword.name,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: EmailPasswordSignInScreen(
                formType: EmailPasswordSignInFormType.signIn,
              ),
            ),
          ),
        ],
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/jobs',
            name: AppRoute.jobs.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: JobsPage(),
            ),
            routes: [
              GoRoute(
                path: 'add',
                name: AppRoute.addJob.name,
                parentNavigatorKey: _rootNavigatorKey,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: EditJobPage(),
                  );
                },
              ),
              GoRoute(
                path: ':id',
                name: AppRoute.job.name,
                pageBuilder: (context, state) {
                  final id = state.params['id']!;
                  final extra = state.extra;
                  // extra could be a Job or an Entry (see entries/:eid route below)
                  // so we only use it if it's a Job
                  final job = extra is Job ? extra : null;
                  return MaterialPage(
                    key: state.pageKey,
                    child: JobEntriesPage(
                      jobId: id,
                      job: job,
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'entries/add',
                    name: AppRoute.addEntry.name,
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) {
                      final jobId = state.params['id']!;
                      return MaterialPage(
                        key: state.pageKey,
                        fullscreenDialog: true,
                        child: EntryPage(
                          jobId: jobId,
                        ),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'entries/:eid',
                    name: AppRoute.entry.name,
                    pageBuilder: (context, state) {
                      final jobId = state.params['id']!;
                      final entryId = state.params['eid']!;
                      final entry = state.extra as Entry?;
                      return MaterialPage(
                        key: state.pageKey,
                        child: EntryPage(
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
                      final jobId = state.params['id'];
                      final job = state.extra as Job?;
                      return MaterialPage(
                        key: state.pageKey,
                        fullscreenDialog: true,
                        child: EditJobPage(jobId: jobId, job: job),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/entries',
            name: AppRoute.entries.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: EntriesPage(),
            ),
          ),
          GoRoute(
            path: '/account',
            name: AppRoute.account.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: AccountScreen(),
            ),
          ),
        ],
      ),
    ],
    //errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
