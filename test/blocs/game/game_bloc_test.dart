import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:letamind/blocs/game/game_bloc.dart';
import 'package:letamind/data/settings.dart';
import 'package:letamind/data/word_provider.dart';
import 'package:mockito/mockito.dart';

class MockSettingsProvider extends Mock implements SettingsProvider {}

class MockDictionaryProvider extends Mock implements DictionaryProvider {}

void main() {
  group('game bloc', () {
    SettingsProvider settingsProvider;
    DictionaryProvider dictionaryProvider;
    WordProvider wordProvider = WordProvider();

    final testSettings = Settings(language: Language.Dutch, wordLength: 5);

    setUp(() {
      settingsProvider = MockSettingsProvider();
      when(settingsProvider.provide())
          .thenAnswer((_) => Future.value(testSettings));

      dictionaryProvider = MockDictionaryProvider();
      when(dictionaryProvider.provide(any))
          .thenAnswer((_) => Future.value(Dictionary(
                language: Language.Dutch,
                words: ['1234', '12345'],
              )));
    });

    blocTest(
      'inital state',
      build: () async => GameBloc(
        settingsProvider: settingsProvider,
        dictionaryProvider: dictionaryProvider,
        wordProvider: wordProvider,
      ),
      skip: 0,
      expect: [InitialGameState()],
    );

    blocTest(
      'start game',
      build: () async => GameBloc(
        settingsProvider: settingsProvider,
        dictionaryProvider: dictionaryProvider,
        wordProvider: wordProvider,
      ),
      act: (bloc) => bloc.add(StartNewGame()),
      expect: [PlayState(wordLength: 5, moves: [], finished: false)],
    );
  });
}
