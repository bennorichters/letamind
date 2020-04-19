import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:letamind/blocs/settings/settings_bloc.dart';
import 'package:letamind/data/settings.dart';
import 'package:letamind/data/word_provider.dart';
import 'package:letamind/screens/game/game_screen.dart';
import 'package:letamind/screens/settings/settings_screen.dart';
import 'package:letamind/utils/text.dart';

import 'blocs/game/game_bloc.dart';

class LetamindApp extends StatefulWidget {
  const LetamindApp({
    @required this.settingsProvider,
    @required this.dictionaryProvider,
    @required this.wordProvider,
    @required this.textProvider,
  });
  final SettingsProvider settingsProvider;
  final DictionaryProvider dictionaryProvider;
  final WordProvider wordProvider;
  final TextProvider textProvider;

  @override
  State<StatefulWidget> createState() => LetamindState();
}

class LetamindState extends State<LetamindApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
        [
          SystemChrome.setPreferredOrientations(
            [
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ],
          ),
          widget.textProvider.provide(),
        ],
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          TranslationExtenion.texts = snapshot.data[1];

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
              debugShowCheckedModeBanner: false,
              title: 'Letamind',
              routes: {
                'settings': (context) => SettingsScreen(),
                'game': (context) => GameScreen(),
              },
              initialRoute: 'settings',
              theme: ThemeData(primarySwatch: Colors.purple),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
