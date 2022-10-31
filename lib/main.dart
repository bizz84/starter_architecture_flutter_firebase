//import 'package:auth_widget_builder/auth_widget_builder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter_architecture_flutter_firebase/firebase_options.dart';
import 'package:starter_architecture_flutter_firebase/src/auth_widget.dart';
import 'package:starter_architecture_flutter_firebase/src/features/home/home_page.dart';
import 'package:starter_architecture_flutter_firebase/src/features/onboarding/onboarding_page.dart';
import 'package:starter_architecture_flutter_firebase/src/features/onboarding/onboarding_view_model.dart';
import 'package:starter_architecture_flutter_firebase/src/features/sign_in/sign_in_page.dart';
import 'package:starter_architecture_flutter_firebase/src/routing/app_router.dart';
import 'package:starter_architecture_flutter_firebase/src/services/shared_preferences_service.dart';
import 'package:starter_architecture_flutter_firebase/src/top_level_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [
      sharedPreferencesServiceProvider.overrideWithValue(
        SharedPreferencesService(sharedPreferences),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseAuth = ref.read(firebaseAuthProvider);
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.indigo),
      debugShowCheckedModeBanner: false,
      home: AuthWidget(
        nonSignedInBuilder: (_) => Consumer(
          builder: (context, ref, _) {
            final didCompleteOnboarding =
                ref.watch(onboardingViewModelProvider);
            return didCompleteOnboarding ? SignInPage() : OnboardingPage();
          },
        ),
        signedInBuilder: (_) => HomePage(),
      ),
      onGenerateRoute: (settings) =>
          AppRouter.onGenerateRoute(settings, firebaseAuth),
    );
  }
}
