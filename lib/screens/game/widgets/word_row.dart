import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letamind/blocs/game/game_bloc.dart';
import 'package:letamind/screens/game/utils/size_data.dart';
import 'package:letamind/screens/game/widgets/letter_box.dart';
import 'package:letamind/screens/game/widgets/letter_input_box.dart';

class WordRow extends StatelessWidget {
  const WordRow({
    @required this.letters,
    @required this.sizeData,
    @required this.color,
    @required this.readOnly,
  });
  final List<String> letters;
  final SizeData sizeData;
  final Color color;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: letters
          .asMap()
          .map(
            (i, letter) => MapEntry(
              i,
              readOnly
                  ? LetterBox(
                      letter: letter,
                      color: color,
                      sizeData: sizeData,
                    )
                  : LetterInputBox(
                      letter: letter,
                      color: color,
                      sizeData: sizeData,
                      onChangeCallback: (String letter) {
                        BlocProvider.of(context).add(EnteredLetter(
                          position: i,
                          letter: letter,
                        ));
                      },
                      isLast: i == letters.length - 1,
                    ),
            ),
          )
          .values
          .toList(),
    );
  }
}
