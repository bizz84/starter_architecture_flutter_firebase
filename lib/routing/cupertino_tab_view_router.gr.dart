// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:starter_architecture_flutter_firebase/app/home/job_entries/job_entries_page.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/job.dart';

abstract class Routes {
  static const jobEntriesPage = '/job-entries-page';
}

class CupertinoTabViewRouter extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<CupertinoTabViewRouter>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.jobEntriesPage:
        if (hasInvalidArgs<JobEntriesPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<JobEntriesPageArguments>(args);
        }
        final typedArgs = args as JobEntriesPageArguments;
        return CupertinoPageRoute<dynamic>(
          builder: (_) => JobEntriesPage(job: typedArgs.job),
          settings: settings,
          fullscreenDialog: false,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//JobEntriesPage arguments holder class
class JobEntriesPageArguments {
  final Job job;
  JobEntriesPageArguments({@required this.job});
}
