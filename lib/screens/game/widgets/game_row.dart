import 'package:flutter/material.dart';

class GameRow extends StatelessWidget {
  const GameRow({@required this.children, @required this.endOfRow});
  final List<Widget> children;
  final Widget endOfRow;

  static const _space = SizedBox(width: 10);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(children: children),
        _space,
        endOfRow,
      ],
    );
  }
}
