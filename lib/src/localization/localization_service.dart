import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LocalizationService {
  static const List<Locale> _supportedLanguages = [Locale('en', 'US'), Locale('es', 'MX'), Locale('fr', 'CA')];
  static const Locale _fallbackLanguage = Locale('en', 'US');

  static Locale getDeviceLocale() {
    final platformDispatcher = PlatformDispatcher.instance;
    final deviceLocales = platformDispatcher.locales;
    debugPrint("Raw device locales: $deviceLocales");

    // Try to find a supported locale
    for (var deviceLocale in deviceLocales) {
      // Check for exact match
      if (_supportedLanguages.contains(deviceLocale)) {
        debugPrint("Using device locale: $deviceLocale");
        return deviceLocale;
      }

      // Check for language match
      final matchingLocale =
          _supportedLanguages.where((locale) => locale.languageCode == deviceLocale.languageCode).firstOrNull;

      if (matchingLocale != null) {
        debugPrint("Using matched locale: $matchingLocale");
        return matchingLocale;
      }
    }

    // If no match found, use fallback
    debugPrint("Using fallback locale: $_fallbackLanguage");
    return _fallbackLanguage;
  }

  static Future setLocaleFromDevice(BuildContext context) async {
    final deviceLocale = getDeviceLocale();
    await setLocale(context, deviceLocale);
  }

  static setLocale(BuildContext context, Locale locale) async {
    await context.setLocale(locale);
  }

  static Locale getFallbackLocale() {
    return _fallbackLanguage;
  }

  static Locale getCurrentLocale(BuildContext context) {
    return context.locale;
  }

  static List<Locale> getSupportedLocales() {
    return _supportedLanguages;
  }
}
