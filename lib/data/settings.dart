import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

const _defaultSettings = Settings(
  language: 'nl',
  wordLength: 5,
);

const _storageKey = 'letamind';

class Settings {
  const Settings({this.language, this.wordLength});

  Settings.fromJson(Map<String, dynamic> json)
      : language = json['language'],
        wordLength = json['wordLength'];

  final String language;
  final int wordLength;

  Map<String, dynamic> toJson() => {
        'language': language,
        'wordLength': wordLength,
      };
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
