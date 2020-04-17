import 'package:flutter/material.dart';

class GameRow extends StatelessWidget {
  const GameRow({@required this.children, @required this.endOfRow});
  final List<Widget> children;
  final Widget endOfRow;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: children),
        endOfRow,
      ],
    );
  }
}
