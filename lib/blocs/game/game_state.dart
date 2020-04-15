part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  const GameState();
}

class InitialGameState extends GameState {
  const InitialGameState();

  @override
  List<Object> get props => [];
}

class PlayState extends GameState {
  const PlayState({
    @required this.wordLength,
    @required this.moves,
    @required this.finished,
  });
  final int wordLength;
  final List<Move> moves;
  final bool finished;


  @override
  List<Object> get props => [wordLength, moves, finished];

  @override
  bool get stringify => true;
}
