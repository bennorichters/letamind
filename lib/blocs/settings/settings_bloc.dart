import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:letamind/data/settings.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(this.settingsProvider);
  final SettingsProvider settingsProvider;

  @override
  SettingsState get initialState => SettingsState(null);

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is UpdateSettings) {
      yield SettingsState(event.settings);
    } else if (event is SaveSettings) {
      await settingsProvider.save(event.settings);
      yield SettingsState(event.settings);
    }
  }
}
