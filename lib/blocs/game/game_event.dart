part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class StartNewGame extends GameEvent {
  const StartNewGame();

  @override
  List<Object> get props => null;
}

class EnteredLetter extends GameEvent {
  const EnteredLetter({@required this.position, @required this.letter});
  final int position;
  final String letter;

  @override
  List<Object> get props => [position, letter];
}

class SubmitGuess extends GameEvent {
  const SubmitGuess(this.guess);
  final String guess;

  @override
  List<Object> get props => [guess];
}
