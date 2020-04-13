import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LetterBox extends StatefulWidget {
  const LetterBox({@required this.letter, @required this.borderColor});
  final String letter;
  final Color borderColor;

  @override
  State<StatefulWidget> createState() => _LetterBoxState();
}

class _LetterBoxState extends State<LetterBox> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: _controller.text.length,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.letter;

    return Padding(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Container(
        height: 50.0,
        width: 50.0,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 5, color: widget.borderColor),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Center(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(border: InputBorder.none),
              enableInteractiveSelection: false,
              focusNode: _focusNode,
              inputFormatters: [LengthLimitingTextInputFormatter(1)],
              onChanged: (value) {
                _controller.value = TextEditingValue(
                  text: value.toUpperCase(),
                  selection: _controller.selection,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
