part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  Settings get settings;
}

class SettingsInitial extends SettingsState {
  const SettingsInitial(this.settings);
  final Settings settings;

  @override
  List<Object> get props => [];
}
