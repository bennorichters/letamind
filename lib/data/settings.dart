import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _defaultSettings = Settings(
  language: Language.Dutch,
  wordLength: 5,
);

const _storageKey = 'letamind';

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

Language _fromCode(String code) =>
    Language.values.firstWhere((value) => value.code == code);

class Settings extends Equatable {
  const Settings({this.language, this.wordLength});

  Settings.fromJson(Map<String, dynamic> json)
      : language = _fromCode(json['language']),
        wordLength = json['wordLength'];

  final Language language;
  final int wordLength;

  Settings updateLanguage(Language updatedLanguage) => Settings(
        language: updatedLanguage,
        wordLength: wordLength,
      );

  Settings updateWordLength(int updatedWordLength) => Settings(
        language: language,
        wordLength: updatedWordLength,
      );

  Map<String, dynamic> toJson() => {
        'language': language.code,
        'wordLength': wordLength,
      };

  @override
  List<Object> get props => [language, wordLength];

  @override
  bool get stringify => true;
}

class SettingsProvider {
  Future<Settings> provide() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return (prefs.containsKey(_storageKey))
        ? Settings.fromJson(jsonDecode(prefs.getString(_storageKey)))
        : _defaultSettings;
  }

  Future<void> save(Settings settings) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _storageKey,
      jsonEncode(settings.toJson()),
    );
  }
}
