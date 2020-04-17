import 'package:flutter/material.dart';
import 'package:letamind/screens/game/utils/size_data.dart';
import 'package:letamind/screens/game/widgets/game_row.dart';
import 'package:letamind/screens/game/widgets/move/letter_box.dart';

class LetterRow extends StatelessWidget {
  const LetterRow({
    @required this.word,
    @required this.sizeData,
    @required this.color,
    @required this.endOfRowWidget,
  });
  final String word;
  final SizeData sizeData;
  final Color color;
  final Widget endOfRowWidget;

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
                  color: color,
                  sizeData: sizeData,
                ),
              )))
          .values
          .toList(),
      endOfRow: endOfRowWidget,
    );
  }
}
