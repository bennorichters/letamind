import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letamind/screens/game/widgets/letter_box.dart';

class WordRow extends StatelessWidget {
  const WordRow({@required this.length});
  final int length;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.filled(
        length,
        LetterBox(
          letter: '?',
          borderColor: Colors.green,
        ),
      ),
    );
  }
}
