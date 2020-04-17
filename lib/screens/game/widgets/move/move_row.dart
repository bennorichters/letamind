import 'package:flutter/material.dart';
import 'package:letamind/blocs/game/game_bloc.dart';
import 'package:letamind/screens/game/utils/size_data.dart';
import 'package:letamind/screens/game/widgets/move/letter_row.dart';

class MoveRow extends StatelessWidget {
  const MoveRow({
    @required this.index,
    @required this.length,
    @required this.move,
    @required this.sizeData,
  });
  final int index;
  final int length;
  final Move move;
  final SizeData sizeData;

  @override
  Widget build(BuildContext context) {
    final color = Color.fromRGBO(
      Colors.green.red,
      Colors.green.green,
      Colors.green.blue,
      1 - index / length,
    );

    return LetterRow(
      word: move.guess,
      sizeData: sizeData,
      color: color,
      endOfRowWidget: Container(
        width: sizeData.size * 2 + sizeData.padding * 2,
        height: sizeData.size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Text(move.score.toString()),
      ),
    );
  }
}
