import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letamind/blocs/game/game_bloc.dart';
import 'package:letamind/screens/game/utils/size_calculator.dart';
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
          final width = MediaQuery.of(context).size.width;
          print('GameScreen - width: $width');
          final length = 4;
          final sizeData = SizeCalculator.create(length: length, width: width);

          return Scaffold(
            appBar: AppBar(
              title: const Text('Letamind'),
            ),
            body: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Table(
                  columnWidths: {
                    0: FixedColumnWidth(
                        (sizeData.size + 2 * sizeData.padding) * length +
                            5),
                    1: FixedColumnWidth(
                        (sizeData.size + 2 * sizeData.padding) * 2 + 5),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: WordRow(
                            length: length,
                            sizeData: sizeData,
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
                          ),
                        ),
                        TableCell(
                          child: WordRow(
                            length: 2,
                            sizeData: sizeData,
                          ),
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
