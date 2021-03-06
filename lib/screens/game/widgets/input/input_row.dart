import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letamind/blocs/game/game_bloc.dart';
import 'package:letamind/screens/game/utils/size_data.dart';
import 'package:letamind/screens/game/widgets/actions/action_row.dart';
import 'package:letamind/screens/game/widgets/game_row.dart';
import 'package:letamind/utils/text.dart';

import 'letter_input_box.dart';

class InputRow extends StatefulWidget {
  const InputRow({
    @required this.length,
    @required this.allowedLetters,
    @required this.sizeData,
  });
  final int length;
  final Set<String> allowedLetters;
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
    return GameRow(
      children: List.generate(
        widget.length,
        (i) => Padding(
          padding: EdgeInsets.only(
            left: (i == 0 ? 0 : widget.sizeData.padding * 2),
          ),
          child: LetterInputBox(
            sizeData: widget.sizeData,
            autofocus: i == 0,
            controller: _controllers[i],
            focusNode: _focusNodes[i],
            onChanged: (value) {
              if (value.trim().isEmpty || value == _emptyBoxChar) {
                _controllers[i].value = TextEditingValue(
                  text: _controllers[i].text,
                  selection: _textSelection,
                );
              } else {
                _focusNodes[i].nextFocus();
              }
            },
          ),
        ),
      ),
      endOfRow: ActionRow(
        sizeData: widget.sizeData,
        icon1: const Icon(Icons.cloud_upload),
        color1: Colors.lightGreen,
        onTap1: () {
          final validation = _validateGuess();
          if (validation['valid']) {
            _clearBoxes();
            _focusNodes[0].requestFocus();
            _controllers[0].value = TextEditingValue(
              text: _controllers[0].text,
              selection: _textSelection,
            );
            BlocProvider.of<GameBloc>(context)
                .add(SubmitGuess(guess: validation['guess']));
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('input_error'.tr),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('invalid_chars_msg'.tr),
                      Text(
                        validation['invalidLetters'].join(', '),
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  actions: [
                    FlatButton(
                      child: Text('ok'.tr),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                );
              },
            );
          }
        },
        icon2: const Icon(Icons.cancel),
        color2: Colors.red,
        onTap2: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('resign'.tr),
                content: Text('resign_question'.tr),
                actions: [
                  FlatButton(
                    child: Text('yes'.tr),
                    onPressed: () {
                      Navigator.of(context).pop();
                      BlocProvider.of<GameBloc>(context)
                          .add(const ResignGame());
                    },
                  ),
                  FlatButton(
                    child: Text('no_play_on'.tr),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Map<String, dynamic> _validateGuess() {
    final result = StringBuffer();

    final invalidLetters = <String>[];
    for (var i = 0; i < widget.length; i++) {
      final letter = _controllers[i].text;

      if (!widget.allowedLetters.contains(letter.toLowerCase())) {
        invalidLetters.add(letter);
      }

      result.write(letter);
    }

    return invalidLetters.isEmpty
        ? {'valid': true, 'guess': result.toString()}
        : {'valid': false, 'invalidLetters': invalidLetters.toSet()};
  }

  void _clearBoxes() => _controllers.forEach((c) => c.text = _emptyBoxChar);
}
