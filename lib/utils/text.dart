import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:letamind/data/word_provider.dart';

extension TranslationExtenion on String {
  static Language language = Language.English;
  static Map<String, Map<String, String>> texts;

  String get tr => texts[language.code].keys.contains(this)
      ? texts[language.code][this]
      : (this[0].toUpperCase() + this.substring(1)).replaceAll('_', ' ');
}

abstract class TextProvider {
  Future<Map<String, Map<String, String>>> provide();
}

class AssetTextProvider implements TextProvider {
  Map<String, Map<String, String>> _texts;

  @override
  Future<Map<String, Map<String, String>>> provide() async =>
      (_texts ??= await _readAssets());

  Future<Map<String, Map<String, String>>> _readAssets() async {
    final result = <String, Map<String, String>>{};
    for (final language in Language.values) {
      final json = await rootBundle
          .loadString('assets/lang/${language.code}/resources.json');
      final resources =
          (jsonDecode(json) as Map<String, dynamic>).cast<String, String>();
      result[language.code] = resources;
    }

    return result;
  }
}
