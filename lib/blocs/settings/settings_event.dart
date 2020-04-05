part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class RetrieveSettings extends SettingsEvent {
  const RetrieveSettings();

  @override
  List<Object> get props => [];
}

class UpdateSettings extends SettingsEvent {
  const UpdateSettings(this.settings);
  final Settings settings;

  @override
  List<Object> get props => [settings];
}

class SaveSettings extends SettingsEvent {
  const SaveSettings(this.settings);
  final Settings settings;

  @override
  List<Object> get props => [settings];
}
