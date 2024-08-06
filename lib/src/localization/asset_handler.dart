import 'dart:convert';
import 'dart:io';
import 'package:flutter_starter_base_app/src/api/mock_api.dart';
import 'package:flutter_starter_base_app/src/localization/localization_service.dart';
import 'package:flutter_starter_base_app/src/utils/translation_storage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class AssetHandler extends AssetLoader {
  static final Map<String, Map<String, dynamic>> _cachedData = {};
  static final Set<String> _apiCalledLocales = {};

  //TODO: Handle multiple calls due to use of fallback translation property
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    final localeKey = _getLocaleString(locale);

    try {
      // Check if domain for this locale is already cached in memory
      if (_cachedData.containsKey(localeKey)) {
        return _cachedData[localeKey]!;
      }

      // If API call hasn't been made for this locale, try API
      if (!_apiCalledLocales.contains(localeKey)) {
        final apiData = await _loadFromApi(locale);
        if (apiData != null) {
          _cachedData[localeKey] = apiData;
          _apiCalledLocales.add(localeKey);
          return _cachedData[localeKey]!;
        }
      }

      final translationStorage = TranslationStorage(locale: locale);
      final localFilePath = await translationStorage.localizedFilePath;
      final localFile = File('$localFilePath/$localeKey.json');

      // Try to load from local file
      if (await localFile.exists()) {
        final localData = await translationStorage.readTranslationFile();
        _cachedData[localeKey] = json.decode(localData);
        return _cachedData[localeKey]!;
      }

      // Fallback to asset
      _cachedData[localeKey] = await _loadFromAsset(path, locale);
      return _cachedData[localeKey]!;
    } catch (e) {
      debugPrint(e.toString());
      // Fallback to fallback language asset
      final fallbackLocale = LocalizationService.getFallbackLocale();

      return await _loadFromAsset(path, fallbackLocale);
    }
  }

  Future<Map<String, dynamic>?> _loadFromApi(Locale locale) async {
    final localeKey = _getLocaleString(locale);
    try {
      final data = await APIMock().getInformationText(localeKey);
      if (data != null) {
        // Save the domain to local storage
        final translationStorage = TranslationStorage(locale: locale);
        await translationStorage.writeTranslationFile(json.encode(data));
        return data;
      }
      return null;
    } catch (e) {
      debugPrint('Error loading from API: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> _loadFromAsset(String path, Locale locale) async {
    try {
      final assetPath = '$path/${_getLocaleString(locale)}.json';
      final data = await rootBundle.loadString(assetPath);
      return json.decode(data);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to load asset file');
    }
  }

  String _getLocaleString(Locale locale) {
    return '${locale.languageCode}-${locale.countryCode}';
  }
}
