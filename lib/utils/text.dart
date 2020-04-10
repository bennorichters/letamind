import 'package:letamind/data/settings.dart';

extension TranslationExtenion on String {
  static Language language = Language.English;
  String get tr => _texts[language.code][this];
}

const _texts = {
  'en': {
    'word_length': 'Word length',
  },
  'nl': {
    'word_length': 'Woordlengte',
  },
  'hu': {
    'word_length': 'Szóhossz',
  },
};
