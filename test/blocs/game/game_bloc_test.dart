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
      expect: [
        PlayState(
          enteredLetters: [null, null, null, null, null],
          moves: [],
          finished: false,
        )
      ],
    );

    blocTest(
      'enter letter',
      build: () async => GameBloc(
        settingsProvider: settingsProvider,
        dictionaryProvider: dictionaryProvider,
        wordProvider: wordProvider,
      ),
      act: (bloc) {
        bloc.add(StartNewGame());
        bloc.add(EnteredLetter(position: 2, letter: 'a'));
        return;
      },
      skip: 2,
      expect: [
        PlayState(
          enteredLetters: [null, null, 'A', null, null],
          moves: [],
          finished: false,
        )
      ],
    );

    blocTest(
      'enter two letters',
      build: () async => GameBloc(
        settingsProvider: settingsProvider,
        dictionaryProvider: dictionaryProvider,
        wordProvider: wordProvider,
      ),
      act: (bloc) {
        bloc.add(StartNewGame());
        bloc.add(EnteredLetter(position: 2, letter: 'a'));
        bloc.add(EnteredLetter(position: 3, letter: 'b'));
        return;
      },
      skip: 3,
      expect: [
        PlayState(
          enteredLetters: [null, null, 'A', 'B', null],
          moves: [],
          finished: false,
        )
      ],
    );

    @isTest
    void scoreTest(String guess, int expectedScore) {
      blocTest(
        'guess word $guess yields score of $expectedScore',
        build: () async => GameBloc(
          settingsProvider: settingsProvider,
          dictionaryProvider: dictionaryProvider,
          wordProvider: wordProvider,
        ),
        act: (bloc) {
          bloc.add(StartNewGame());
          bloc.add(EnteredLetter(position: 0, letter: guess.substring(0, 1)));
          bloc.add(EnteredLetter(position: 1, letter: guess.substring(1, 2)));
          bloc.add(EnteredLetter(position: 2, letter: guess.substring(2, 3)));
          bloc.add(EnteredLetter(position: 3, letter: guess.substring(3, 4)));
          bloc.add(EnteredLetter(position: 4, letter: guess.substring(4, 5)));
          bloc.add(SubmitGuess());
          return;
        },
        skip: 7,
        expect: [
          PlayState(
            enteredLetters: guess.split(''),
            moves: [Move(guess: guess, score: expectedScore)],
            finished: false,
          )
        ],
      );
    }

    scoreTest('11111', 2);
    scoreTest('22222', 2);
    scoreTest('00000', 0);
    scoreTest('01000', 1);
    scoreTest('31333', 3);
    scoreTest('32333', 4);
    scoreTest('12345', 10);
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
