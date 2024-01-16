import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/src/routing/app_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static const primaryColor = Colors.indigo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      theme: ThemeData(
        colorSchemeSeed: primaryColor,
        unselectedWidgetColor: Colors.grey,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2.0,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: Colors.grey[200],
        dividerColor: Colors.grey[400],
        // https://github.com/firebase/flutterfire/blob/master/packages/firebase_ui_auth/doc/theming.md
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
