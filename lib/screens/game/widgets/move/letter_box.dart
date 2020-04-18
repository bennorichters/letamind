import 'package:flutter/material.dart';
import 'package:letamind/screens/game/utils/size_data.dart';

class LetterBox extends StatelessWidget {
  const LetterBox({
    @required this.letter,
    @required this.backgroundColor,
    @required this.sizeData,
    this.color = Colors.black,
  });
  final String letter;
  final Color backgroundColor;
  final SizeData sizeData;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeData.size,
      height: sizeData.size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Center(
        child: Text(
          letter,
          style: TextStyle(
            color: color,
            fontSize: sizeData.font,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
