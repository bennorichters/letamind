import 'package:letamind/data/settings.dart';

extension TranslationExtenion on String {
  static Language language = Language.English;
  String get tr => _texts[language.code][this];
}

const _texts = {
  'en': {
    'settings': 'Settings',
    'word_length': 'Word length',
  },
  'nl': {
    'settings': 'Instellingen',
    'word_length': 'Woordlengte',
  },
  'hu': {
    'settings': 'Beállítások',
    'word_length': 'Szóhossz',
  },
};
