import 'package:flutter/material.dart';
import 'package:letamind/screens/game/utils/size_data.dart';
import 'package:letamind/screens/game/widgets/game_row.dart';
import 'package:letamind/screens/game/widgets/move/letter_box.dart';

class LetterRow extends StatelessWidget {
  const LetterRow({
    @required this.word,
    @required this.sizeData,
    @required this.backgroundColor,
    @required this.endOfRowWidget,
    this.color = Colors.black,
  });
  final String word;
  final SizeData sizeData;
  final Color backgroundColor;
  final Widget endOfRowWidget;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GameRow(
      children: word
          .split('')
          .asMap()
          .map((i, letter) => MapEntry(
              i,
              Padding(
                padding: EdgeInsets.only(
                  left: (i == 0 ? 0 : sizeData.padding * 2),
                ),
                child: LetterBox(
                  letter: letter,
                  backgroundColor: backgroundColor,
                  sizeData: sizeData,
                  color: color,
                ),
              )))
          .values
          .toList(),
      endOfRow: endOfRowWidget,
    );
  }
}
