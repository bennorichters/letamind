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

const _data = {
  414: {
    4: {
      'padding': 4.0,
      'border': 5.0,
      'size': 55.0,
      'font': 18.0,
      'cPadding': 5.0,
    },
    5: {
      'padding': 3.0,
      'border': 4.0,
      'size': 48.0,
      'font': 18.0,
      'cPadding': 5.0,
    },
    6: {
      'padding': 2.5,
      'border': 3.0,
      'size': 45.0,
      'font': 17.0,
      'cPadding': 9.0,
    },
    7: {
      'padding': 2.0,
      'border': 2.5,
      'size': 40.0,
      'font': 16.0,
      'cPadding': 11.0,
    },
    8: {
      'padding': 1.5,
      'border': 2.0,
      'size': 37.0,
      'font': 15.0,
      'cPadding': 13.0,
    },
  },
  375: {
    4: {
      'padding': 3.5,
      'border': 4.0,
      'size': 52.0,
      'font': 18.0,
      'cPadding': 5.0,
    },
    5: {
      'padding': 2.5,
      'border': 3.5,
      'size': 45.0,
      'font': 18.0,
      'cPadding': 5.0,
    },
    6: {
      'padding': 2.0,
      'border': 2.5,
      'size': 40.0,
      'font': 17.0,
      'cPadding': 9.0,
    },
    7: {
      'padding': 1.5,
      'border': 2.0,
      'size': 37.0,
      'font': 16.0,
      'cPadding': 11.0,
    },
    8: {
      'padding': 1.5,
      'border': 1.0,
      'size': 33.0,
      'font': 15.0,
      'cPadding': 13.0,
    },
  },
  360: {
    4: {
      'padding': 3.0,
      'border': 4.0,
      'size': 52.0,
      'font': 18.0,
      'cPadding': 5.0,
    },
    5: {
      'padding': 2.5,
      'border': 3.5,
      'size': 45.0,
      'font': 18.0,
      'cPadding': 5.0,
    },
    6: {
      'padding': 1.8,
      'border': 2.5,
      'size': 39.0,
      'font': 17.0,
      'cPadding': 9.0,
    },
    7: {
      'padding': 1.5,
      'border': 2.0,
      'size': 35.0,
      'font': 16.0,
      'cPadding': 17.0,
    },
    8: {
      'padding': 1.5,
      'border': 1.0,
      'size': 31.0,
      'font': 13.0,
      'cPadding': 18.0,
    },
  },
};

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
          final length = 7;
          final sizeData = _data[width.floor()][length];
          final sizeCalculator = SizeCalculator.create(length: length, width: width);
          final double padding = sizeCalculator.padding;

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
                        (sizeData['size'] + 2 * padding) * length +
                            5),
                    1: FixedColumnWidth(
                        (sizeData['size'] + 2 * padding) * 2 + 5),
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
