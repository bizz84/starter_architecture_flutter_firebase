import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/src/routing/app_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        unselectedWidgetColor: Colors.grey,
        appBarTheme: const AppBarTheme(
          elevation: 2.0,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
