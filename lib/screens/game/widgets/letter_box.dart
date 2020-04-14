import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:letamind/screens/game/utils/size_data.dart';

class LetterBox extends StatefulWidget {
  const LetterBox({
    @required this.letter,
    @required this.color,
    @required this.sizeData,
    @required this.readOnly,
  });
  final String letter;
  final Color color;
  final SizeData sizeData;
  final bool readOnly;

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
        child: Container(
          decoration: BoxDecoration(
            color: widget.readOnly ? widget.color : Colors.transparent,
            border: Border.all(
              width: widget.sizeData.border,
              color: widget.color,
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
            readOnly: widget.readOnly,
            style: TextStyle(
                fontSize: widget.sizeData.font, fontWeight: FontWeight.bold),
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
