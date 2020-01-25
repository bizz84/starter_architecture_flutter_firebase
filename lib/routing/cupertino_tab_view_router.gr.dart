// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:starter_architecture_flutter_firebase/app/home/job_entries/job_entries_page.dart';
import 'package:starter_architecture_flutter_firebase/services/database.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/job.dart';

class CupertinoTabViewRouter {
  static const jobEntriesPage = '/job-entries-page';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<CupertinoTabViewRouter>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case CupertinoTabViewRouter.jobEntriesPage:
        if (hasInvalidArgs<JobEntriesPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<JobEntriesPageArguments>(args);
        }
        final typedArgs = args as JobEntriesPageArguments;
        return CupertinoPageRoute(
          builder: (_) =>
              JobEntriesPage(database: typedArgs.database, job: typedArgs.job),
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
  final FirestoreDatabase database;
  final Job job;
  JobEntriesPageArguments({@required this.database, @required this.job});
}
