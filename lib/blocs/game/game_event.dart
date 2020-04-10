part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class StartNewGame extends GameEvent {
  const StartNewGame();

  @override
  List<Object> get props => null;
}

class SubmitGuess extends GameEvent {
  const SubmitGuess(this.guess);
  final String guess;

  @override
  List<Object> get props => [guess];
}
