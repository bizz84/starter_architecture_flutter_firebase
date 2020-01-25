import 'package:starter_architecture_flutter_firebase/app/auth_widget_builder.dart';
import 'package:starter_architecture_flutter_firebase/app/auth_widget.dart';
import 'package:starter_architecture_flutter_firebase/routing/router.gr.dart';
import 'package:starter_architecture_flutter_firebase/services/auth_service.dart';
import 'package:starter_architecture_flutter_firebase/services/auth_service_adapter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // [initialAuthServiceType] is made configurable for testing
  const MyApp({this.initialAuthServiceType = AuthServiceType.firebase});
  final AuthServiceType initialAuthServiceType;

  @override
  Widget build(BuildContext context) {
    // MultiProvider for top-level services that can be created right away
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthServiceAdapter(
            initialAuthServiceType: initialAuthServiceType,
          ),
          dispose: (_, AuthService authService) => authService.dispose(),
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
