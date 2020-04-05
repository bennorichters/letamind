import 'package:flutter_test/flutter_test.dart';
import 'package:letamind/data/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('model', () {
    test('direct value constructor', () {
      final settings = Settings(language: 'a', wordLength: 1);
      expect(settings.language, 'a');
      expect(settings.wordLength, 1);
    });

    test('from json', () {
      final json = {'language': 'a', 'wordLength': 1};
      final settings = Settings.fromJson(json);
      expect(settings.language, 'a');
      expect(settings.wordLength, 1);
    });

    test('to json', () {
      final settings = Settings(language: 'a', wordLength: 1);
      final json = settings.toJson();
      expect(json['language'], 'a');
      expect(json['wordLength'], 1);
    });
  });

  group('provider', () {
    setUp(() {
      SharedPreferences.setMockInitialValues(<String, dynamic>{});
    });

    test('nothing stored, default settings', () async {
      final settings = await SettingsProvider().provide();
      expect(settings.language, 'nl');
      expect(settings.wordLength, 5);
    });

    test('save', () async {
      final provider = SettingsProvider();
      final settings = Settings(language: 'a', wordLength: 1);
      await provider.save(settings);

      final retrievedSettings = await provider.provide();
      expect(retrievedSettings.language, 'a');
      expect(retrievedSettings.wordLength, 1);
    });
  });
}
