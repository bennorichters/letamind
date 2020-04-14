import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:letamind/data/settings.dart';
import 'package:letamind/data/word_provider.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc({
    @required this.settingsProvider,
    @required this.dictionaryProvider,
    @required this.wordProvider,
  });
  final SettingsProvider settingsProvider;
  final DictionaryProvider dictionaryProvider;
  final WordProvider wordProvider;

  String _word;
  List<String> _enteredLetters;
  List<Move> _moves = [];
  bool _finished = false;

  @override
  GameState get initialState => InitialGameState();

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if (event is StartNewGame) {
      final settings = await settingsProvider.provide();
      final dict = await dictionaryProvider.provide(settings.language);
      wordProvider.dictionary = dict;
      _word = wordProvider.random(settings.wordLength).toUpperCase();
      // print('Word to guess: $_word');
      _enteredLetters = List.generate(settings.wordLength, (_) => null);
      _moves = [];
      _finished = false;

      yield _fromProps();
    } else if (event is EnteredLetter) {
      _enteredLetters[event.position] = event.letter.toUpperCase();
      yield _fromProps();
    } else if (event is SubmitGuess) {
      int score = 0;

      for (int i = 0; i < _word.length; i++) {
        String char = _word[i];
        if (_enteredLetters[i] == char) {
          score += 2;
        } else if (_enteredLetters.contains(char)) {
          score++;
        }
      }

      _moves.add(Move(letters: [..._enteredLetters], score: score));
      _enteredLetters.fillRange(0, _enteredLetters.length, null);
      yield _fromProps();
    }
  }

  PlayState _fromProps() => PlayState(
        enteredLetters: [..._enteredLetters],
        moves: [..._moves],
        finished: _finished,
      );
}

class Move extends Equatable {
  const Move({@required this.letters, @required this.score});
  final List<String> letters;
  final int score;

  @override
  List<Object> get props => [letters, score];

  @override
  bool get stringify => true;
}
