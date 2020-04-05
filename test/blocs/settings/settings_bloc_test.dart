import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:letamind/data/settings.dart';
import 'package:mockito/mockito.dart';

import 'package:letamind/blocs/settings/settings_bloc.dart';

class MockSettingsProvider extends Mock implements SettingsProvider {}

void main() {
  group('settings bloc', () {
    final testSettings = Settings(language: Language.Dutch, wordLength: 1);
    SettingsProvider provider;

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
      'retrieve get default settings',
      build: () async => SettingsBloc(provider),
      act: (bloc) => bloc.add(RetrieveSettings()),
      expect: [SettingsState(testSettings)],
    );

    blocTest(
      'update emit same settings',
      build: () async => SettingsBloc(provider),
      act: (bloc) {
        bloc.add(RetrieveSettings());
        bloc.add(UpdateSettings(language: Language.Hungarian));
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
    );

    blocTest(
      'save triggers provider save and emit same settings',
      build: () async => SettingsBloc(provider),
      act: (bloc) {
        bloc.add(RetrieveSettings());
        bloc.add(SaveSettings());
        return;
      },
      skip: 2,
      expect: [SavedSettings(testSettings)],
      verify: (_) async => verify(provider.save(testSettings)).called(1),
    );
  });
}
