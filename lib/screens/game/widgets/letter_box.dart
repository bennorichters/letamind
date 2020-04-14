import 'package:flutter/material.dart';
import 'package:letamind/screens/game/utils/size_data.dart';

class LetterBox extends StatelessWidget {
  const LetterBox({
    @required this.letter,
    @required this.color,
    @required this.sizeData,
  });
  final String letter;
  final Color color;
  final SizeData sizeData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(sizeData.padding),
      child: Container(
        width: sizeData.size,
        height: sizeData.size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Center(
          child: Text(
            letter,
            style: TextStyle(
              fontSize: sizeData.font,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
