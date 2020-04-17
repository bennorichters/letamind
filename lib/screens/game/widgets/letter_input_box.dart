import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:letamind/screens/game/utils/size_data.dart';

class LetterInputBox extends StatelessWidget {
  const LetterInputBox({
    @required this.sizeData,
    @required this.autofocus,
    @required this.controller,
    @required this.focusNode,
  });
  final SizeData sizeData;
  final bool autofocus;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeData.size,
      width: sizeData.size,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            width: sizeData.border,
            color: Colors.green,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: TextField(
          autofocus: autofocus,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(bottom: sizeData.cPadding),
          ),
          enableInteractiveSelection: false,
          focusNode: focusNode,
          inputFormatters: [LengthLimitingTextInputFormatter(1)],
          onChanged: (_) => focusNode.nextFocus(),
          style: TextStyle(
            fontSize: sizeData.font,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
