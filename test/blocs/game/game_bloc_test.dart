import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:letamind/blocs/game/game_bloc.dart';
import 'package:letamind/data/settings.dart';
import 'package:letamind/data/word_provider.dart';
import 'package:mockito/mockito.dart';

import 'package:meta/meta.dart';

class MockSettingsProvider extends Mock implements SettingsProvider {}

class MockDictionaryProvider extends Mock implements DictionaryProvider {}

void main() {
  group('game bloc', () {
    SettingsProvider settingsProvider;
    DictionaryProvider numberDictionaryProvider;
    DictionaryProvider letterDictionaryProvider;
    WordProvider wordProvider = WordProvider();

    final testSettings = Settings(language: Language.Dutch, wordLength: 5);

    setUp(() {
      settingsProvider = MockSettingsProvider();
      when(settingsProvider.provide())
          .thenAnswer((_) => Future.value(testSettings));

      numberDictionaryProvider = MockDictionaryProvider();
      when(numberDictionaryProvider.provide(any))
          .thenAnswer((_) => Future.value(Dictionary(
                language: Language.Dutch,
                allowedLetters: {},
                words: ['1234', '12345'],
              )));

      letterDictionaryProvider = MockDictionaryProvider();
      when(letterDictionaryProvider.provide(any))
          .thenAnswer((_) => Future.value(Dictionary(
                language: Language.Dutch,
                allowedLetters: {},
                words: ['abcde'],
              )));
    });

    blocTest(
      'inital state',
      build: () async => GameBloc(
        settingsProvider: settingsProvider,
        dictionaryProvider: numberDictionaryProvider,
        wordProvider: wordProvider,
      ),
      skip: 0,
      expect: [InitialGameState()],
    );

    blocTest(
      'start game',
      build: () async => GameBloc(
        settingsProvider: settingsProvider,
        dictionaryProvider: numberDictionaryProvider,
        wordProvider: wordProvider,
      ),
      act: (bloc) => bloc.add(StartNewGame()),
      expect: [
        PlayState(
          solution: '12345',
          allowedLetters: {},
          moves: [],
          status: GameStatus.ongoing,
        )
      ],
    );

    blocTest(
      'case insensitive guess',
      build: () async => GameBloc(
        settingsProvider: settingsProvider,
        dictionaryProvider: letterDictionaryProvider,
        wordProvider: wordProvider,
      ),
      act: (bloc) {
        bloc.add(StartNewGame());
        bloc.add(SubmitGuess(guess: 'abcde'));
        return;
      },
      skip: 2,
      expect: [
        PlayState(
          solution: 'ABCDE',
          allowedLetters: {},
          moves: [Move(guess: 'ABCDE', score: 10)],
          status: GameStatus.solved,
        )
      ],
    );

    blocTest(
      'resign game',
      build: () async => GameBloc(
        settingsProvider: settingsProvider,
        dictionaryProvider: numberDictionaryProvider,
        wordProvider: wordProvider,
      ),
      act: (bloc) {
        bloc.add(StartNewGame());
        bloc.add(ResignGame());
        return;
      },
      skip: 2,
      expect: [
        PlayState(
          solution: '12345',
          allowedLetters: {},
          moves: [],
          status: GameStatus.resigned,
        )
      ],
    );

    @isTest
    void scoreTest(String guess, int expectedScore, [bool solved = false]) {
      blocTest(
        'guess word $guess yields score of $expectedScore',
        build: () async => GameBloc(
          settingsProvider: settingsProvider,
          dictionaryProvider: numberDictionaryProvider,
          wordProvider: wordProvider,
        ),
        act: (bloc) {
          bloc.add(StartNewGame());
          bloc.add(SubmitGuess(guess: guess));
          return;
        },
        skip: 2,
        expect: [
          PlayState(
            solution: '12345',
            allowedLetters: {},
            moves: [Move(guess: guess, score: expectedScore)],
            status: solved ? GameStatus.solved : GameStatus.ongoing,
          )
        ],
      );
    }

    scoreTest('12345', 10, true);
    scoreTest('11111', 2);
    scoreTest('22222', 2);
    scoreTest('00000', 0);
    scoreTest('01000', 1);
    scoreTest('31333', 3);
    scoreTest('32333', 4);
    scoreTest('12341', 8);
    scoreTest('12340', 8);
    scoreTest('01234', 4);
    scoreTest('01235', 5);
    scoreTest('01243', 5);
    scoreTest('52345', 8);
    scoreTest('13345', 8);
    scoreTest('21245', 6);
    scoreTest('13245', 8);
    scoreTest('33932', 2);
    scoreTest('92399', 4);
    scoreTest('92939', 3);
  });
}
