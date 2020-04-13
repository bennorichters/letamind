import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letamind/screens/game/utils/size_data.dart';
import 'package:letamind/screens/game/widgets/letter_box.dart';

class WordRow extends StatelessWidget {
  const WordRow({@required this.length, @required this.sizeData});
  final int length;
  final SizeData sizeData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.filled(
        length,
        LetterBox(
          letter: '?',
          borderColor: Colors.green,
          sizeData: sizeData,
        ),
      ),
    );
  }
}
