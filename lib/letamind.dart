import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:letamind/blocs/settings/settings_bloc.dart';
import 'package:letamind/data/settings.dart';
import 'package:letamind/screens/settings/settings_screen.dart';

class LetamindApp extends StatefulWidget {
  const LetamindApp(this.settingsProvider);
  final SettingsProvider settingsProvider;

  @override
  State<StatefulWidget> createState() => LetamindState();
}

class LetamindState extends State<LetamindApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (BuildContext context) => SettingsBloc(widget.settingsProvider),
      child: MaterialApp(
        title: 'Letamind',
        routes: {
          'settings': (context) => SettingsScreen(),
        },
        initialRoute: 'settings', 
      ),
    );
  }
}
