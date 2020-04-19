import 'dart:math' show min;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letamind/blocs/game/game_bloc.dart';
import 'package:letamind/screens/game/utils/size_data.dart';
import 'package:letamind/screens/game/widgets/actions/action_row.dart';
import 'package:letamind/screens/game/widgets/input/input_row.dart';
import 'package:letamind/screens/game/widgets/move/letter_row.dart';
import 'package:letamind/screens/game/widgets/move/move_row.dart';
import 'package:letamind/utils/text.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GameBloc>(context).add(const StartNewGame());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(builder: (
      BuildContext context,
      GameState state,
    ) {
      if (state is PlayState) {
        final width = min(
          SizeData.maxScreenWidth,
          MediaQuery.of(context).size.width,
        );
        final sizeData = SizeData.create(
          length: state.wordLength,
          width: width,
        );

        final message = _message(state);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Letamind'),
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
              child: Container(
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    state.status == GameStatus.ongoing
                        ? InputRow(
                            length: state.wordLength,
                            allowedLetters: state.allowedLetters,
                            sizeData: sizeData,
                          )
                        : LetterRow(
                            word: state.solution,
                            sizeData: sizeData,
                            backgroundColor: Colors.purple,
                            color: Colors.white,
                            endOfRowWidget: ActionRow(
                              icon1: Icon(Icons.play_arrow),
                              color1: Colors.blue,
                              onTap1: () => BlocProvider.of<GameBloc>(context)
                                  .add(const StartNewGame()),
                              icon2: Icon(Icons.settings),
                              color2: Colors.blue,
                              onTap2: () => Navigator.pushReplacementNamed(
                                context,
                                'settings',
                              ),
                              sizeData: sizeData,
                            ),
                          ),
                    if (message != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              message,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    Flexible(
                      child: ListView(
                        children: state.moves.reversed
                            .toList()
                            .asMap()
                            .map((i, move) => MapEntry(
                                  i,
                                  MoveRow(
                                    index: state.moves.length - i - 1,
                                    length: state.moves.length,
                                    sizeData: sizeData,
                                    move: move,
                                  ),
                                ))
                            .values
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }

      return const Center(child: CircularProgressIndicator());
    });
  }

  _message(PlayState state) {
    if (state.status == GameStatus.ongoing && state.moves.isEmpty) {
      return 'intro'.tr + '\n\n' + 'rules'.tr;
    }

    if (state.status == GameStatus.solved ||
        state.status == GameStatus.resigned) {
      var message = '';
      if (state.status == GameStatus.solved) {
        message = 'solved'.tr + '\n\n';
      }

      return message + 'play_again'.tr;
    }

    return null;
  }
}
