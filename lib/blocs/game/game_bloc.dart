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
  Set<String> _allowedLetters;
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
      _allowedLetters = dict.allowedLetters;
      _word = wordProvider.random(settings.wordLength).toUpperCase();
      // print('Word to guess: $_word');
      _moves = [];
      _finished = false;

      yield _fromProps();
    } else if (event is SubmitGuess) {
      final guess = event.guess.toUpperCase();

      int score = 0;
      for (int i = 0; i < _word.length; i++) {
        String guessedLetter = guess[i];
        String correctLetter = _word[i];
        if (guessedLetter == correctLetter) {
          score += 2;
        } else if (event.guess.contains(correctLetter)) {
          score++;
        }
      }

      _finished = (guess == _word);

      _moves.add(Move(guess: guess, score: score));
      yield _fromProps();
    }
  }

  PlayState _fromProps() => PlayState(
        wordLength: _word.length,
        allowedLetters: _allowedLetters,
        moves: [..._moves],
        finished: _finished,
      );
}

class Move extends Equatable {
  const Move({@required this.guess, @required this.score});
  final String guess;
  final int score;

  @override
  List<Object> get props => [guess, score];

  @override
  bool get stringify => true;
}
