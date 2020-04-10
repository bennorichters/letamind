part of 'game_bloc.dart';

class GameState extends Equatable {
  const GameState({this.word, this.moves, this.finished});
  final String word;
  final List<Move> moves;
  final bool finished;

  @override
  List<Object> get props => [word, moves, finished];
}
