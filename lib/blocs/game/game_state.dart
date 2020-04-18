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
    @required this.solution,
    @required this.allowedLetters,
    @required this.moves,
    @required this.status,
  });
  final String solution;
  final Set<String> allowedLetters;
  final List<Move> moves;
  final GameStatus status;

  int get wordLength => solution.length;

  @override
  List<Object> get props => [solution, allowedLetters, moves, status];

  @override
  bool get stringify => true;
}
