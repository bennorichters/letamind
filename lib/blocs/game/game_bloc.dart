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
      _word = wordProvider.random(settings.wordLength);
      _moves = [];
      _finished = false;

      yield PlayState(
        wordLength: settings.wordLength,
        moves: _moves,
        finished: _finished,
      );
    } else if (event is SubmitGuess) {
      String guess = event.guess;
      int score = 0;

      for (int i = 0; i < _word.length; i++) {
        String char = _word[i];
        if (guess[i] == char) {
          score += 2;
        } else if (guess.contains(char)) {
          score++;
        }
      }

      yield PlayState(
        wordLength: _word.length,
        moves: _moves..add(Move(guess: guess, score: score)),
        finished: false,
      );
    }
  }
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
