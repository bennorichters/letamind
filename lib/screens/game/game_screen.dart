import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letamind/blocs/game/game_bloc.dart';
import 'package:letamind/screens/game/utils/size_data.dart';
import 'package:letamind/screens/game/widgets/word_row.dart';

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
                    Table(
                      columnWidths: {
                        0: FixedColumnWidth(
                          (sizeData.size + 2 * sizeData.padding) * length + 5,
                        ),
                        1: FixedColumnWidth(
                          (sizeData.size + 2 * sizeData.padding) * 2 + 5,
                        ),
                      },
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: WordRow(
                                length: length,
                                sizeData: sizeData,
                                color: Colors.blue,
                                word: '?' * length,
                                readOnly: true,
                              ),
                            ),
                            TableCell(child: Container()),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: WordRow(
                                length: length,
                                sizeData: sizeData,
                                color: Colors.green,
                                word: '_' * length,
                                readOnly: false,
                              ),
                            ),
                            TableCell(
                              child: WordRow(
                                length: 2,
                                sizeData: sizeData,
                                color: Colors.amber,
                                word: 'VX',
                                readOnly: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
