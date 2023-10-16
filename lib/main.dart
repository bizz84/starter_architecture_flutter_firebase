import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_architecture_flutter_firebase/src/app_startup.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // final sharedPreferences = await SharedPreferences.getInstance();
  // turn off the # in the URLs on the web
  usePathUrlStrategy();
  // * Register error handlers. For more info, see:
  // * https://docs.flutter.dev/testing/errors
  registerErrorHandlers();
  // * Entry point of the app
  runApp(const ProviderScope(
    child: AsyncApp(),
  ));

  // final container = ProviderContainer(
  //   overrides: [
  //     onboardingRepositoryProvider.overrideWithValue(
  //       OnboardingRepository(sharedPreferences),
  //     ),
  //   ],
  // );
  // runApp(UncontrolledProviderScope(
  //   container: container,
  //   child: const MyApp(),
  // ));
}
