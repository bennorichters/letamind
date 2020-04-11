import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:letamind/blocs/settings/settings_bloc.dart';
import 'package:letamind/data/settings.dart';
import 'package:letamind/data/word_provider.dart';
import 'package:letamind/screens/game/game_screen.dart';
import 'package:letamind/screens/settings/settings_screen.dart';

import 'blocs/game/game_bloc.dart';

class LetamindApp extends StatefulWidget {
  const LetamindApp({
    @required this.settingsProvider,
    @required this.dictionaryProvider,
    @required this.wordProvider,
  });
  final SettingsProvider settingsProvider;
  final DictionaryProvider dictionaryProvider;
  final WordProvider wordProvider;

  @override
  State<StatefulWidget> createState() => LetamindState();
}

class LetamindState extends State<LetamindApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>(
          create: (BuildContext context) =>
              SettingsBloc(widget.settingsProvider),
        ),
        BlocProvider<GameBloc>(
          create: (BuildContext context) => GameBloc(
            settingsProvider: widget.settingsProvider,
            dictionaryProvider: widget.dictionaryProvider,
            wordProvider: widget.wordProvider,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Letamind',
        routes: {
          'settings': (context) => SettingsScreen(),
          'game': (context) => GameScreen(),
        },
        initialRoute: 'settings',
      ),
    );
  }
}
