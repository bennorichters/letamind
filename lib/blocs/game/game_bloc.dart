import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:letamind/data/settings.dart';
import 'package:letamind/data/word_provider.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc({this.settingsProvider, this.wordProvider});
  final SettingsProvider settingsProvider;
  final WordProvider wordProvider;

  String _word;
  List<Move> _moves = [];
  bool _finished = false;

  @override
  GameState get initialState => GameState(
        word: _word,
        moves: _moves,
        finished: _finished,
      );

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if (event is SubmitMove) {}
  }
}

class Move extends Equatable {
  const Move({this.guess, this.score});
  final String guess;
  final int score;

  @override
  List<Object> get props => [guess, score];
}
