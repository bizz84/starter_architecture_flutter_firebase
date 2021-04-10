import 'package:email_password_sign_in_ui/email_password_sign_in_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:starter_architecture_flutter_firebase/app/home/browse/search_page_result.dart';
import 'package:starter_architecture_flutter_firebase/app/home/history/add_sells_page.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/entry.dart';
import 'package:starter_architecture_flutter_firebase/app/home/models/item.dart';

class AppRoutes {
  static const emailPasswordSignInPage = '/email-password-sign-in-page';
  static const editItemPage = '/edit-item-page';
  static const browsePage = '/browse-page';

}

class AppRouter {
  static Route<dynamic>? onGenerateRoute(
      RouteSettings settings, FirebaseAuth firebaseAuth) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.browsePage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SearchPageResult(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.emailPasswordSignInPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => EmailPasswordSignInPage.withFirebaseAuth(firebaseAuth,
              onSignedIn: args as void Function()),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.editItemPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => EditItemPage(item: args as Item?),
          settings: settings,
          fullscreenDialog: true,
        );
      default:
        // TODO: Throw
        return null;
    }
  }
}
