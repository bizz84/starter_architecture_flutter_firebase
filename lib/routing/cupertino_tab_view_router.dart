// import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:starter_architecture_flutter_firebase/app/home/job_entries/job_entries_page.dart';

// Reverting back to manually generated routes until this is clarified: https://github.com/Milad-Akarie/auto_route_library/issues/62
// @CupertinoAutoRouter()
// class $CupertinoTabViewRouter {
//   @CupertinoRoute(fullscreenDialog: false)
//   JobEntriesPage jobEntriesPage;
// }

class CupertinoTabViewRoutes {
  static const jobEntriesPage = '/job-entries-page';
}

class CupertinoTabViewRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CupertinoTabViewRoutes.jobEntriesPage:
        final job = settings.arguments;
        return CupertinoPageRoute(
          builder: (_) => JobEntriesPage(job: job),
          settings: settings,
          fullscreenDialog: true,
        );
    }
    return null;
  }
}
