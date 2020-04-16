import 'package:flutter_test/flutter_test.dart';
import 'package:letamind/data/settings.dart';
import 'package:letamind/data/word_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('settings', () {
    final testSettings = Settings(language: Language.Hungarian, wordLength: 1);

    group('model', () {
      test('direct value constructor', () {
        final settings = testSettings;
        expect(settings.language, Language.Hungarian);
        expect(settings.wordLength, 1);
      });

      test('from json', () {
        final json = {'language': 'hu', 'wordLength': 1};
        final settings = Settings.fromJson(json);
        expect(settings.language, Language.Hungarian);
        expect(settings.wordLength, 1);
      });

      test('to json', () {
        final settings = testSettings;
        final json = settings.toJson();
        expect(json['language'], 'hu');
        expect(json['wordLength'], 1);
      });
    });

    group('provider', () {
      setUp(() {
        SharedPreferences.setMockInitialValues(<String, dynamic>{});
      });

      test('nothing stored, default settings', () async {
        final settings = await SettingsProvider().provide();
        expect(settings.language, Language.Dutch);
        expect(settings.wordLength, 5);
      });

      test('save', () async {
        final provider = SettingsProvider();
        final settings = testSettings;
        await provider.save(settings);

        final retrievedSettings = await provider.provide();
        expect(retrievedSettings.language, Language.Hungarian);
        expect(retrievedSettings.wordLength, 1);
      });
    });
  });
}
