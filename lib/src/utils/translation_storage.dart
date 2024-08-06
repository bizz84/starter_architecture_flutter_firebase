import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class TranslationStorage {
  final Locale locale;
  static const int _cacheExpirationHours = 24;
  TranslationStorage({required this.locale});
  Future<String> get localizedFilePath async => (await getApplicationDocumentsDirectory()).path;
  Future<File> get _localizedFile async => File('${await localizedFilePath}/${locale.languageCode}-${locale.countryCode}.json');

  Future<String> readTranslationFile() async {
    try {
      return await (await _localizedFile).readAsString();
    } catch (e) {
      //todo
    }
    throw Exception('Failed to read localized values');
  }

  Future<File> writeTranslationFile(String translationJson) async {
    try {
      return (await _localizedFile).writeAsString(translationJson);
    } catch (e) {
      // todo
    }
    throw Exception('Failed to write localized values');
  }

  Future<bool> isFileOutdated(File file) async =>
      !await file.exists() || DateTime.now().difference((await file.stat()).modified).inHours >= _cacheExpirationHours;
}
