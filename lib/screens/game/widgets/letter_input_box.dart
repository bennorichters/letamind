import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:letamind/screens/game/utils/size_data.dart';

class LetterInputBox extends StatefulWidget {
  const LetterInputBox({
    @required this.letter,
    @required this.sizeData,
    @required this.onChangeCallback,
    @required this.autofocus,
    @required Key key,
  }) : super(key: key);
  final String letter;
  final SizeData sizeData;
  final Function onChangeCallback;
  final bool autofocus;

  @override
  State<StatefulWidget> createState() => _LetterInputBoxState();
}

const _textSelection = TextSelection(
  baseOffset: 0,
  extentOffset: 1,
);

class _LetterInputBoxState extends State<LetterInputBox> {
  TextEditingController _controller;
  FocusNode _focusNode;

  @override
  initState() {
    super.initState();

    _controller = TextEditingController();
    _controller.text = widget.letter;
  
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.selection = _textSelection;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.sizeData.padding),
      child: Container(
        height: widget.sizeData.size,
        width: widget.sizeData.size,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              width: widget.sizeData.border,
              color: Colors.green,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: widget.sizeData.cPadding),
            ),
            enableInteractiveSelection: false,
            focusNode: _focusNode,
            inputFormatters: [LengthLimitingTextInputFormatter(1)],
            style: TextStyle(
              fontSize: widget.sizeData.font,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            autofocus: widget.autofocus,
            onChanged: (value) {
              final fixedValue = _fixValue(value);
              _controller.value = TextEditingValue(
                text: fixedValue,
                selection: _textSelection,
              );

              _focusNode.nextFocus();

              widget.onChangeCallback(fixedValue);
            },
          ),
        ),
      ),
    );
  }

  String _fixValue(String value) => (value == null || value.trim().isEmpty)
      ? '_'
      : value.substring(0, 1).toUpperCase();
}
