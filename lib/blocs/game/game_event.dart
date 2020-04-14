part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class StartNewGame extends GameEvent {
  const StartNewGame();
}

class EnteredLetter extends GameEvent {
  const EnteredLetter({@required this.position, @required this.letter});
  final int position;
  final String letter;

  @override
  List<Object> get props => [position, letter];
}

class SubmitGuess extends GameEvent {
  const SubmitGuess();
}
