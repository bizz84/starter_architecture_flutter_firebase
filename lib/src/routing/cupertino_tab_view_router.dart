import 'package:flutter/cupertino.dart';
import 'package:starter_architecture_flutter_firebase/src/features/home/models/job.dart';
import 'package:starter_architecture_flutter_firebase/src/features/job_entries/job_entries_page.dart';

class CupertinoTabViewRoutes {
  static const jobEntriesPage = '/job-entries-page';
}

// ignore:avoid_classes_with_only_static_members
class CupertinoTabViewRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CupertinoTabViewRoutes.jobEntriesPage:
        final job = settings.arguments as Job;
        return CupertinoPageRoute(
          builder: (_) => JobEntriesPage(job: job),
          settings: settings,
          fullscreenDialog: false,
        );
    }
    return null;
  }
}
