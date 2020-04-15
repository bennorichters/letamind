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

class SubmitGuess extends GameEvent {
  const SubmitGuess({this.guess});
  final String guess;

  @override
  List<Object> get props => [guess];
}
