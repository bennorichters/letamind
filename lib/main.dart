import 'package:flutter/material.dart';
import 'package:letamind/data/settings.dart';
import 'package:letamind/data/word_provider.dart';
import 'package:letamind/letamind.dart';

class TempDictionaryProvider extends DictionaryProvider {
  @override
  Future<Dictionary> provide(Language language) => Future.value(
        Dictionary(
          words: [
            '1234',
            '12345',
            '123456',
            '1234567',
            '12345678',
          ],
        ),
      );
}

void main() => runApp(
      LetamindApp(
        settingsProvider: SettingsProvider(),
        dictionaryProvider: TempDictionaryProvider(),
        wordProvider: WordProvider(),
      ),
    );
