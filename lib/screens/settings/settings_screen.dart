import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letamind/blocs/settings/settings_bloc.dart';
import 'package:letamind/data/word_provider.dart';
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
          body: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Center(
              child: Table(
                columnWidths: {
                  0: FixedColumnWidth(120),
                  1: FixedColumnWidth(200)
                },
                children: [
                  TableRow(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Taal'),
                          const Text('Language'),
                          const Text('Nyelv'),
                        ],
                      ),
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                                              child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        ),
                      ),
                    ],
                  ),
                  TableRow(children: [SizedBox(height: 20), Container()]),
                  TableRow(
                    children: [
                      TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('word_length'.tr +
                                ' (${state.settings.wordLength})'),
                          ],
                        ),
                      ),
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
