
import 'package:flutter/material.dart';

class WordLengthSelector extends StatefulWidget {
  const WordLengthSelector({@required this.value, @required this.onChangeEnd});
  final int value;
  final ValueChanged<double> onChangeEnd;

  @override
  State<StatefulWidget> createState() => _WordLengthSelectorState(value);
}

class _WordLengthSelectorState extends State<WordLengthSelector> {
  _WordLengthSelectorState(this.selectedValue);
  int selectedValue;

  @override
  Widget build(BuildContext context) {
    return Slider(
      label: selectedValue.toString(),
      value: selectedValue.toDouble(),
      min: 4,
      max: 8,
      divisions: 4,
      onChanged: (double newValue) =>
          setState(() => selectedValue = newValue.floor()),
      onChangeEnd: widget.onChangeEnd,
    );
  }
}
