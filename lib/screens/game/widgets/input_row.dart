import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letamind/blocs/game/game_bloc.dart';
import 'package:letamind/screens/game/utils/size_data.dart';

import 'letter_input_box.dart';

class InputRow extends StatefulWidget {
  const InputRow({@required this.length, @required this.sizeData});
  final int length;
  final SizeData sizeData;

  @override
  State<StatefulWidget> createState() => _InputRowState();
}

class _InputRowState extends State<InputRow> {
  // A FocusNode cannot be initialized in the build method
  // See https://stackoverflow.com/questions/56038010/
  final _controllers = <TextEditingController>[];
  final _focusNodes = <FocusNode>[];

  static const _emptyBoxChar = '_';
  static const _textSelection = TextSelection(baseOffset: 0, extentOffset: 1);
  static String _fixText(String value) =>
      (value == null || value.trim().isEmpty)
          ? _emptyBoxChar
          : value.substring(0, 1).toUpperCase();

  static const space = SizedBox(width: 10);

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < widget.length; i++) {
      final controller = TextEditingController()..text = _emptyBoxChar;
      final focusNode = FocusNode();

      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          controller.value = TextEditingValue(
            text: controller.text,
            selection: _textSelection,
          );
        }
      });

      controller.addListener(() {
        final fixedText = _fixText(controller.text);
        controller.value = controller.value.copyWith(
          text: fixedText,
          composing: TextRange.empty,
        );
      });

      _controllers.add(controller);
      _focusNodes.add(focusNode);
    }
  }

  @override
  void dispose() {
    _focusNodes.forEach((fn) => fn.dispose());
    _controllers.forEach((c) => c.dispose());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: List.generate(
            widget.length,
            (i) => LetterInputBox(
              sizeData: widget.sizeData,
              autofocus: i == 0,
              controller: _controllers[i],
              focusNode: _focusNodes[i],
            ),
          ),
        ),
        space,
        Row(
          children: [
            _SubmitButton(
              sizeData: widget.sizeData,
              color: Colors.amber,
              icon: const Icon(Icons.cloud_upload),
              onTap: () {
                final guess = _guessedWord(widget.length);
                _clearBoxes();
                _focusNodes[0].requestFocus();
                _controllers[0].value = TextEditingValue(
                  text: _controllers[0].text,
                  selection: _textSelection,
                );
                BlocProvider.of<GameBloc>(context)
                    .add(SubmitGuess(guess: guess));
              },
            ),
            _SubmitButton(
              sizeData: widget.sizeData,
              color: Colors.red,
              icon: const Icon(Icons.cancel),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  _guessedWord(int length) {
    final result = StringBuffer();
    for (var i = 0; i < length; i++) {
      result.write(_controllers[i].text);
    }

    return result.toString();
  }

  void _clearBoxes() => _controllers.forEach((c) => c.text = _emptyBoxChar);
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    @required this.sizeData,
    @required this.color,
    @required this.icon,
    @required this.onTap,
  });
  final SizeData sizeData;
  final Color color;
  final Icon icon;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(sizeData.padding),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: sizeData.size,
          height: sizeData.size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Center(child: icon),
        ),
      ),
    );
  }
}
