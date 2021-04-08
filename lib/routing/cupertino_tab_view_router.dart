import 'package:flutter/cupertino.dart';
import 'package:starter_architecture_flutter_firebase/app/home/job_entries/item_details.dart';
import 'package:starter_architecture_flutter_firebase/app/home/search/search_page_result.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/job.dart';
import 'package:starter_architecture_flutter_firebase/app/home/sells/sells_details.dart';

class CupertinoTabViewRoutes {
  static const jobEntriesPage = '/job-entries-page';
  static const sellProductPage = '/sell-product-page';
}

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
      case CupertinoTabViewRoutes.sellProductPage: 
        final job = settings.arguments as Job;
        return CupertinoPageRoute(
          builder: (_) => SellProductPage(job: job),
          settings: settings,
          fullscreenDialog: false,
        );
    }
    return null;
  }
}
