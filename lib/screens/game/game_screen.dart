import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letamind/blocs/game/game_bloc.dart';
import 'package:letamind/screens/game/utils/size_data.dart';
import 'package:letamind/screens/game/widgets/input_row.dart';
import 'package:letamind/screens/game/widgets/letter_row.dart';

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
                padding: EdgeInsets.only(top: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InputRow(
                      length: state.wordLength,
                      allowedLetters: state.allowedLetters,
                      sizeData: sizeData,
                    ),
                    state.moves.isEmpty
                        ? Text('nothing')
                        : Flexible(
                            child: ListView(
                              children: state.moves.reversed
                                  .map((move) => LetterRow(
                                        word: move.guess,
                                        sizeData: sizeData,
                                        endOfRowWidget:
                                            Text(move.score.toString()),
                                      ))
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
