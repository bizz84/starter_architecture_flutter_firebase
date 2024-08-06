import 'package:flutter_starter_base_app/src/localization/asset_handler.dart';
import 'package:flutter_starter_base_app/src/localization/localization_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' show ConsumerWidget, ProviderScope, WidgetRef;
import 'package:flutter_starter_base_app/main.reflectable.dart';
import 'package:flutter_starter_base_app/src/routing/app_router.dart' show goRouterProvider;
import 'package:flutter_starter_base_app/src/utils/error_handler.dart';
import 'package:flutter_starter_base_app/src/constants/theme_data.dart';

void main() async {
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  await EasyLocalization.ensureInitialized();
  registerErrorHandlers();
  initializeReflectable();
  FlutterNativeSplash.remove();
  runApp(ProviderScope(
      child: EasyLocalization(
          supportedLocales: LocalizationService.getSupportedLocales(),
          path: 'assets/locale',
          useFallbackTranslations: true,
          useFallbackTranslationsForEmptyResources: true,
          fallbackLocale: LocalizationService.getFallbackLocale(),
          startLocale: LocalizationService.getDeviceLocale(),
          saveLocale: false,
          assetLoader: AssetHandler(),
          child: const EVChargerApp())));
}

class EVChargerApp extends ConsumerWidget {
  const EVChargerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: DanlawTheme().themeData,
        debugShowCheckedModeBanner: false,
        routerConfig: ref.watch(goRouterProvider),
      );
}
