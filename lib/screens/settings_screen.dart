import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letamind/blocs/settings/settings_bloc.dart';
import 'package:letamind/keys.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
        builder: (BuildContext context, SettingsState state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
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
                      _TappableFlag('nl', true),
                      _TappableFlag('en', false),
                      _TappableFlag('hu', false),
                    ],
                  ),
                ],
              ),
              TableRow(
                children: [
                  Text('Woordlengte'),
                  _WordLengthSelector(5),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Start',
          child: Icon(Icons.play_arrow),
        ),
      );
    });
  }
}

class _TappableFlag extends StatelessWidget {
  const _TappableFlag(this.languageCode, this.enabled);
  final String languageCode;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
      child: GestureDetector(
        key: Key(settings_language_prefix + languageCode),
        onTap: () {},
        child: Opacity(
          opacity: enabled ? 1.0 : 0.3,
          child: Image.asset(
            'assets/lang/' + languageCode + '/flag40.png',
            width: 40.0,
            height: 40.0,
          ),
        ),
      ),
    );
  }
}

class _WordLengthSelector extends StatefulWidget {
  const _WordLengthSelector(this.value);
  final int value;

  @override
  State<StatefulWidget> createState() => _WordLengthSelectorState(value);
}

class _WordLengthSelectorState extends State<_WordLengthSelector> {
  _WordLengthSelectorState(this.selectedValue);
  int selectedValue;

  @override
  Widget build(BuildContext context) {
    return Slider(
      label: selectedValue.toString(),
      value: selectedValue.toDouble(),
      min: 4,
      max: 8,
      divisions: 4,
      onChanged: (double newValue) =>
          setState(() => selectedValue = newValue.floor()),
      onChangeEnd: (_) {},
    );
  }
}
