import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

enum Language { Dutch, English, Hungarian }

extension LanguageCodeExtension on Language {
  String get code {
    switch (this) {
      case Language.Dutch:
        return 'nl';
      case Language.English:
        return 'en';
      case Language.Hungarian:
        return 'hu';
      default:
        throw Error();
    }
  }
}

class Dictionary {
  const Dictionary({
    @required this.language,
    @required this.allowedLetters,
    @required this.words,
  });
  final Language language;
  final Set<String> allowedLetters;
  final List<String> words;
}

abstract class DictionaryProvider {
  Future<Dictionary> provide(Language language);
}

class AssetDictionaryProvider extends DictionaryProvider {
  @override
  Future<Dictionary> provide(Language language) async {
    final words =
        await rootBundle.loadString('assets/lang/${language.code}/words.dic');

    final json = await rootBundle
        .loadString('assets/lang/${language.code}/allowed_letters.json');
    final List<String> letters =
        (jsonDecode(json) as List<dynamic>).cast<String>();

    return Dictionary(
      language: language,
      allowedLetters: letters.toSet(),
      words: words.split('\n'),
    );
  }
}

class WordProvider {
  Dictionary dictionary;

  Language get language => dictionary.language;

  String random(int length) =>
      (dictionary.words.where((e) => e.length == length).toList()..shuffle())
          .first;
}
