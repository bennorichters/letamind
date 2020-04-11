import 'package:flutter/material.dart';

class LetterBox extends StatelessWidget {
  const LetterBox({@required this.letter, @required this.borderColor});
  final String letter;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Container(
        height: 50.0,
        width: 50.0,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 5, color: borderColor),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Center(
            child: Text(letter),
          ),
        ),
      ),
    );
  }
}
