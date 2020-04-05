import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:letamind/data/settings.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this._settingsProvider);
  final SettingsProvider _settingsProvider;

  Settings _settings;

  @override
  SettingsState get initialState => SettingsState(_settings);

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is RetrieveSettings) {
      _settings = await _settingsProvider.provide();
      yield SettingsState(_settings);
    } else if (event is UpdateSettings) {
      if (event.language != null) {
        _settings = _settings.updateLanguage(event.language);
      }

      if (event.wordLength != null) {
        _settings = _settings.updateWordLength(event.wordLength);
      }

      yield SettingsState(_settings);
    } else if (event is SaveSettings) {
      await _settingsProvider.save(_settings);
      yield SavedSettings(_settings);
    }
  }
}
