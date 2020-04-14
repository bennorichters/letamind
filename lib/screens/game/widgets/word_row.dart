import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letamind/screens/game/utils/size_data.dart';
import 'package:letamind/screens/game/widgets/letter_box.dart';

class WordRow extends StatelessWidget {
  const WordRow({
    @required this.length,
    @required this.sizeData,
    @required this.color,
    @required this.word,
    @required this.readOnly,
  });
  final int length;
  final SizeData sizeData;
  final Color color;
  final String word;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: word
          .split('')
          .map((letter) => LetterBox(
                letter: letter,
                color: color,
                sizeData: sizeData,
                readOnly: readOnly,
              ))
          .toList(),
    );
  }
}
