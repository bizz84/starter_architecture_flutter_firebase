// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:starter_architecture_flutter_firebase/app/auth_widget.dart';
import 'package:starter_architecture_flutter_firebase/services/firebase_auth_service.dart';
import 'package:starter_architecture_flutter_firebase/app/sign_in/email_password/email_password_sign_in_page.dart';
import 'package:starter_architecture_flutter_firebase/app/home/jobs/edit_job_page.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/job.dart';
import 'package:starter_architecture_flutter_firebase/app/home/job_entries/entry_page.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/entry.dart';

class Router {
  static const authWidget = '/';
  static const emailPasswordSignInPageBuilder =
      '/email-password-sign-in-page-builder';
  static const editJobPage = '/edit-job-page';
  static const entryPage = '/entry-page';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.authWidget:
        if (hasInvalidArgs<AuthWidgetArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<AuthWidgetArguments>(args);
        }
        final typedArgs = args as AuthWidgetArguments;
        return MaterialPageRoute(
          builder: (_) => AuthWidget(
              key: typedArgs.key, userSnapshot: typedArgs.userSnapshot),
          settings: settings,
        );
      case Router.emailPasswordSignInPageBuilder:
        if (hasInvalidArgs<EmailPasswordSignInPageBuilderArguments>(args)) {
          return misTypedArgsRoute<EmailPasswordSignInPageBuilderArguments>(
              args);
        }
        final typedArgs = args as EmailPasswordSignInPageBuilderArguments ??
            EmailPasswordSignInPageBuilderArguments();
        return MaterialPageRoute(
          builder: (_) => EmailPasswordSignInPageBuilder(
              key: typedArgs.key, onSignedIn: typedArgs.onSignedIn),
          settings: settings,
          fullscreenDialog: true,
        );
      case Router.editJobPage:
        if (hasInvalidArgs<EditJobPageArguments>(args)) {
          return misTypedArgsRoute<EditJobPageArguments>(args);
        }
        final typedArgs =
            args as EditJobPageArguments ?? EditJobPageArguments();
        return MaterialPageRoute(
          builder: (_) => EditJobPage(key: typedArgs.key, job: typedArgs.job),
          settings: settings,
          fullscreenDialog: true,
        );
      case Router.entryPage:
        if (hasInvalidArgs<EntryPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<EntryPageArguments>(args);
        }
        final typedArgs = args as EntryPageArguments;
        return MaterialPageRoute(
          builder: (_) => EntryPage(job: typedArgs.job, entry: typedArgs.entry),
          settings: settings,
          fullscreenDialog: true,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//AuthWidget arguments holder class
class AuthWidgetArguments {
  final Key key;
  final AsyncSnapshot<User> userSnapshot;
  AuthWidgetArguments({this.key, @required this.userSnapshot});
}

//EmailPasswordSignInPageBuilder arguments holder class
class EmailPasswordSignInPageBuilderArguments {
  final Key key;
  final void Function() onSignedIn;
  EmailPasswordSignInPageBuilderArguments({this.key, this.onSignedIn});
}

//EditJobPage arguments holder class
class EditJobPageArguments {
  final Key key;
  final Job job;
  EditJobPageArguments({this.key, this.job});
}

//EntryPage arguments holder class
class EntryPageArguments {
  final Job job;
  final Entry entry;
  EntryPageArguments({@required this.job, this.entry});
}
