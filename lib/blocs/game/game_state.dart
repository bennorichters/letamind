part of 'game_bloc.dart';

abstract class GameState extends Equatable {
  const GameState();
}

class InitialGameState extends GameState {
  const InitialGameState();

  @override
  List<Object> get props => null;
}

class PlayState extends GameState {
  const PlayState({
    @required this.enteredLetters,
    @required this.moves,
    @required this.finished,
  });
  final List<String> enteredLetters;
  final List<Move> moves;
  final bool finished;

  int get wordLength => enteredLetters.length;

  @override
  List<Object> get props => [enteredLetters, moves, finished];

  @override
  bool get stringify => true;
}
