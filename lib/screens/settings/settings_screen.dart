import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letamind/blocs/settings/settings_bloc.dart';
import 'package:letamind/data/settings.dart';
import 'package:letamind/screens/settings/widgets/tappable_flag.dart';
import 'package:letamind/screens/settings/widgets/word_length_selector.dart';
import 'package:letamind/utils/text.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SettingsBloc>(context).add(const SettingsInit());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (BuildContext context, SettingsState state) {
        if (state is SettingsSaved) {
          Navigator.pushReplacementNamed(context, 'game');
        }
      },
      child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (BuildContext context, SettingsState state) {
        if (state.settings == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('settings'.tr),
          ),
          body: Center(
            child: Table(
              children: [
                TableRow(
                  children: [
                    Column(
                      children: [
                        Text('Taal'),
                        Text('Language'),
                        Text('Nyelv'),
                      ],
                    ),
                    Row(
                      children: [
                        _createTableFlag(
                          context,
                          state.settings.language,
                          Language.Dutch,
                        ),
                        _createTableFlag(
                          context,
                          state.settings.language,
                          Language.English,
                        ),
                        _createTableFlag(
                          context,
                          state.settings.language,
                          Language.Hungarian,
                        ),
                      ],
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text('word_length'.tr + ' (${state.settings.wordLength})'),
                    WordLengthSelector(
                      value: state.settings.wordLength,
                      onChangeEnd: (double value) =>
                          BlocProvider.of<SettingsBloc>(context).add(
                        SettingsUpdated(wordLength: value.floor()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                BlocProvider.of<SettingsBloc>(context).add(SettingsSave()),
            tooltip: 'Start',
            child: Icon(Icons.play_arrow),
          ),
        );
      }),
    );
  }
}

Widget _createTableFlag(
  BuildContext context,
  Language stateLanguage,
  Language flagLanguage,
) {
  return TappableFlag(
    languageCode: flagLanguage.code,
    enabled: stateLanguage == flagLanguage,
    onTap: () => BlocProvider.of<SettingsBloc>(context)
        .add(SettingsUpdated(language: flagLanguage)),
  );
}
