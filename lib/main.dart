import 'package:flutter/material.dart';
import 'package:letamind/data/settings.dart';
import 'package:letamind/data/word_provider.dart';
import 'package:letamind/letamind.dart';
import 'package:letamind/utils/text.dart';

void main() => runApp(
      LetamindApp(
        settingsProvider: SettingsProvider(),
        dictionaryProvider: AssetDictionaryProvider(),
        wordProvider: WordProvider(),
        textProvider: AssetTextProvider(),
      ),
    );
