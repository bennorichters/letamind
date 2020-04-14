import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letamind/blocs/game/game_bloc.dart';
import 'package:letamind/screens/game/utils/size_data.dart';
import 'package:letamind/screens/game/widgets/letter_box.dart';
import 'package:letamind/screens/game/widgets/letter_input_box.dart';

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

          const space = SizedBox(width: 10);
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
                    Row(
                      children: List.generate(
                          length,
                          (_) => LetterBox(
                                letter: '?',
                                color: Colors.blue,
                                sizeData: sizeData,
                              )),
                    ),
                    Row(
                      children: [
                        Row(
                            children: state.enteredLetters
                                .asMap()
                                .map(
                                  (i, letter) => MapEntry(
                                    i,
                                    LetterInputBox(
                                      letter: letter ?? '_',
                                      sizeData: sizeData,
                                      onChangeCallback: (String letter) {
                                        BlocProvider.of<GameBloc>(context).add(
                                          EnteredLetter(
                                            position: i,
                                            letter: letter,
                                          ),
                                        );
                                      },
                                      isLast: i == state.wordLength - 1,
                                    ),
                                  ),
                                )
                                .values
                                .toList()),
                        space,
                        Row(
                          children: [
                            _SubmitButton(
                              sizeData: sizeData,
                              color: Colors.amber,
                              icon: const Icon(Icons.cloud_upload),
                              onTap: () {
                                BlocProvider.of<GameBloc>(context)
                                    .add(SubmitGuess());
                              },
                            ),
                            _SubmitButton(
                              sizeData: sizeData,
                              color: Colors.red,
                              icon: const Icon(Icons.cancel),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                    state.moves.isEmpty
                        ? Text('nothing')
                        : Flexible(
                            child: ListView(
                              children: state.moves.reversed
                                  .map((move) => Row(children: [
                                        Row(
                                          children: move.letters
                                              .map((letter) => LetterBox(
                                                    letter: letter,
                                                    color: Colors.lightGreen,
                                                    sizeData: sizeData,
                                                  ))
                                              .toList(),
                                        ),
                                        space,
                                        Text(move.score.toString())
                                      ]))
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

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    @required this.sizeData,
    @required this.color,
    @required this.icon,
    @required this.onTap,
  });
  final SizeData sizeData;
  final Color color;
  final Icon icon;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(sizeData.padding),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: sizeData.size,
          height: sizeData.size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Center(child: icon),
        ),
      ),
    );
  }
}
