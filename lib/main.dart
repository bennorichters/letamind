import 'package:flutter/material.dart';
import 'package:letamind/data/settings.dart';
import 'package:letamind/data/word_provider.dart';
import 'package:letamind/letamind.dart';

class TempDictionaryProvider extends DictionaryProvider {
  @override
  Future<Dictionary> provide(Language language) =>
      Future.value(Dictionary(words: ['12345']));
}

void main() => runApp(
      LetamindApp(
        settingsProvider: SettingsProvider(),
        dictionaryProvider: TempDictionaryProvider(),
        wordProvider: WordProvider(),
      ),
    );
