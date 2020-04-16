import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:letamind/data/settings.dart';
import 'package:letamind/data/word_provider.dart';
import 'package:letamind/utils/text.dart';
import 'package:mockito/mockito.dart';

import 'package:letamind/blocs/settings/settings_bloc.dart';

class MockSettingsProvider extends Mock implements SettingsProvider {}

void main() {
  group('settings bloc', () {
    SettingsProvider provider;

    final testSettings = Settings(language: Language.Dutch, wordLength: 1);

    setUp(() {
      provider = MockSettingsProvider();
      when(provider.provide()).thenAnswer((_) => Future.value(testSettings));
    });

    blocTest(
      'inital state has null settings',
      build: () async => SettingsBloc(provider),
      skip: 0,
      expect: [SettingsState(null)],
    );

    blocTest(
      'init gets test settings',
      build: () async => SettingsBloc(provider),
      act: (bloc) => bloc.add(SettingsInit()),
      expect: [SettingsState(testSettings)],
      verify: (_) async =>
          expect(TranslationExtenion.language, testSettings.language),
    );

    blocTest(
      'update emit same settings',
      build: () async => SettingsBloc(provider),
      act: (bloc) {
        bloc.add(SettingsInit());
        bloc.add(SettingsUpdated(language: Language.Hungarian));
        return;
      },
      skip: 2,
      expect: [
        SettingsState(
          Settings(
            language: Language.Hungarian,
            wordLength: 1,
          ),
        ),
      ],
      verify: (_) async =>
          expect(TranslationExtenion.language, Language.Hungarian),
    );

    blocTest(
      'save triggers provider save and emit same settings',
      build: () async => SettingsBloc(provider),
      act: (bloc) {
        bloc.add(SettingsInit());
        bloc.add(SettingsSave());
        return;
      },
      skip: 2,
      expect: [SettingsSaved(testSettings)],
      verify: (_) async => verify(provider.save(testSettings)).called(1),
    );
  });
}
