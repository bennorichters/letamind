import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letamind/blocs/game/game_bloc.dart';
import 'package:letamind/screens/game/utils/size_data.dart';
import 'package:letamind/screens/game/widgets/input/input_row.dart';
import 'package:letamind/screens/game/widgets/move/letter_row.dart';
import 'package:letamind/screens/game/widgets/move/move_row.dart';

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
    return BlocListener<GameBloc, GameState>(
      listener: (BuildContext context, GameState state) {
        // if (state is SettingsSaved) {
        //   Navigator.pushReplacementNamed(context, 'settings');
        // }
      },
      child: BlocBuilder<GameBloc, GameState>(builder: (
        BuildContext context,
        GameState state,
      ) {
        if (state is PlayState) {
          final length = state.wordLength;
          final width = MediaQuery.of(context).size.width;
          final sizeData = SizeData.create(length: length, width: width);

          return Scaffold(
            appBar: AppBar(
              title: const Text('Letamind'),
            ),
            body: Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    state.finished
                        ? LetterRow(
                            word: state.moves.last.guess,
                            sizeData: sizeData,
                            color: Colors.purple,
                            endOfRowWidget: Container(),
                          )
                        : InputRow(
                            length: state.wordLength,
                            allowedLetters: state.allowedLetters,
                            sizeData: sizeData,
                          ),
                    state.moves.isEmpty
                        ? Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.lightGreen,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    'Choose your letters in the row above and submit '
                                    'them to see the score you get.',
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Flexible(
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
          );
        }

        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
