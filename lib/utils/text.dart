import 'package:letamind/data/word_provider.dart';

extension TranslationExtenion on String {
  static Language language = Language.English;

  String get tr => _texts[language.code].keys.contains(this)
      ? _texts[language.code][this]
      : (this[0].toUpperCase() + this.substring(1)).replaceAll('_', ' ');
}

const _texts = {
  'en': {},
  'nl': {
    'settings': 'Instellingen',
    'word_length': 'Woordlengte',
  },
  'hu': {
    'settings': 'Beállítások',
    'word_length': 'Szóhossz',
  },
};
