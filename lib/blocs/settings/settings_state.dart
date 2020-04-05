part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState(this.settings);
  final Settings settings;

  @override
  List<Object> get props => [settings];

  @override
  bool get stringify => true;
}

class SavedSettings extends SettingsState {
  const SavedSettings(Settings settings) : super(settings);  
}
