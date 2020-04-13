import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:letamind/screens/game/utils/size_data.dart';

class LetterBox extends StatefulWidget {
  const LetterBox({
    @required this.letter,
    @required this.borderColor,
    @required this.sizeData,
  });
  final String letter;
  final Color borderColor;
  final SizeData sizeData;

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
      padding: EdgeInsets.all(widget.sizeData.padding),
      child: Container(
        height: widget.sizeData.size,
        width: widget.sizeData.size,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: widget.sizeData.border, color: widget.borderColor),
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
            style: TextStyle(fontSize: widget.sizeData.font, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            onChanged: (value) {
              _controller.value = TextEditingValue(
                text: value.toUpperCase(),
                selection: _controller.selection,
              );
            },
          ),
        ),
      ),
    );
  }
}
