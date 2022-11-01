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

// ignore: avoid_classes_with_only_static_members
// class AppRouter {
//   static Route<dynamic>? onGenerateRoute(
//       RouteSettings settings, FirebaseAuth firebaseAuth) {
//     final args = settings.arguments;
//     switch (settings.name) {
//       case AppRoutes.emailPasswordSignInPage:
//         return MaterialPageRoute<dynamic>(
//           builder: (_) => const EmailPasswordSignInScreen(
//             formType: EmailPasswordSignInFormType.signIn,
//           ),
//           settings: settings,
//           fullscreenDialog: true,
//         );
//       case AppRoutes.editJobPage:
//         return MaterialPageRoute<dynamic>(
//           builder: (_) => EditJobPage(job: args as Job?),
//           settings: settings,
//           fullscreenDialog: true,
//         );
//       case AppRoutes.entryPage:
//         final mapArgs = args as Map<String, dynamic>;
//         final job = mapArgs['job'] as Job;
//         final entry = mapArgs['entry'] as Entry?;
//         return MaterialPageRoute<dynamic>(
//           builder: (_) => EntryPage(job: job, entry: entry),
//           settings: settings,
//           fullscreenDialog: true,
//         );
//       default:
//         // TODO: Throw
//         return null;
//     }
//   }
// }

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
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        builder: (context, state) => const SignInScreen(),
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
                  final job = state.extra as Job?;
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
                  // TODO: Figure out why this is not reached, and `jobs/:id` is matched instead
                  GoRoute(
                    path: 'entries/:eid',
                    name: AppRoute.entry.name,
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) {
                      final jobId = state.params['id']!;
                      final entryId = state.params['eid']!;
                      final entry = state.extra as Entry?;
                      return MaterialPage(
                        key: state.pageKey,
                        fullscreenDialog: true,
                        child: EntryPage(
                          jobId: jobId,
                          entryId: entryId,
                          entry: entry,
                        ),
                      );
                    },
                    // TODO: Edit
                    routes: [],
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
