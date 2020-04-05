class Settings {
  const Settings({this.language, this.wordLength});
  final String language;
  final int wordLength;
}

class SettingsProvider {
  Settings provide() => Settings(language: 'nl', wordLength: 5);
}
