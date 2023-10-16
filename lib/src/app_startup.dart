import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter_architecture_flutter_firebase/firebase_options.dart';
import 'package:starter_architecture_flutter_firebase/src/app.dart';
import 'package:starter_architecture_flutter_firebase/src/features/onboarding/data/onboarding_repository.dart';
import 'package:starter_architecture_flutter_firebase/src/localization/string_hardcoded.dart';

part 'app_startup.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<Override>> asyncInit(AsyncInitRef ref) async {
  await Firebase.initializeApp(
    //name: 'unknown',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  return [
    onboardingRepositoryProvider.overrideWithValue(
      OnboardingRepository(sharedPreferences),
    ),
  ];
}

class AsyncApp extends ConsumerWidget {
  const AsyncApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Get all the overrides
    final overridesAsync = ref.watch(asyncInitProvider);
    return overridesAsync.when(
      data: (List<Override> overrides) {
        return ProviderScope(
          overrides: overrides,
          child: const MainApp(),
        );
      },
      // * Show an error if initialization failed
      error: (Object error, StackTrace stackTrace) {
        return MaterialApp(
          home: Scaffold(
            body: Center(child: Text(error.toString())),
          ),
        );
      },
      // * Show some loading UI while the initialization is in progress
      loading: () {
        return const MaterialApp(
          home: Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}

void registerErrorHandlers() {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('An error occurred'.hardcoded),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}
