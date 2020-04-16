import 'package:flutter/material.dart';
import 'package:letamind/screens/game/utils/size_data.dart';
import 'package:letamind/screens/game/widgets/game_row.dart';
import 'package:letamind/screens/game/widgets/letter_box.dart';

class LetterRow extends StatelessWidget {
  const LetterRow({
    @required this.word,
    @required this.sizeData,
    @required this.endOfRowWidget,
  });
  final String word;
  final SizeData sizeData;
  final Widget endOfRowWidget;

  @override
  Widget build(BuildContext context) {
    return GameRow(
      children: word
          .split('')
          .map((letter) => LetterBox(
                letter: letter,
                color: Colors.lightGreen,
                sizeData: sizeData,
              ))
          .toList(),
      endOfRow: endOfRowWidget,
    );
  }
}
