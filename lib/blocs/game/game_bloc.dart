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
    }
  }
}

class Move extends Equatable {
  const Move({this.guess, this.score});
  final String guess;
  final int score;

  @override
  List<Object> get props => [guess, score];
}
