import 'package:starter_architecture_flutter_firebase/app/auth_widget_builder.dart';
import 'package:starter_architecture_flutter_firebase/app/auth_widget.dart';
import 'package:starter_architecture_flutter_firebase/routing/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_architecture_flutter_firebase/services/firebase_auth_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MultiProvider for top-level services that can be created right away
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
      ],
      child: AuthWidgetBuilder(
          builder: (BuildContext context, AsyncSnapshot<User> userSnapshot) {
        return MaterialApp(
          theme: ThemeData(primarySwatch: Colors.indigo),
          home: AuthWidget(userSnapshot: userSnapshot),
          onGenerateRoute: Router.onGenerateRoute,
        );
      }),
    );
  }
}
