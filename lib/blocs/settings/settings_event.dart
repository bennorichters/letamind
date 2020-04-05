part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class SettingsInit extends SettingsEvent {
  const SettingsInit();

  @override
  List<Object> get props => [];
}

class SettingsUpdated extends SettingsEvent {
  const SettingsUpdated({this.language, this.wordLength});
  final Language language;
  final int wordLength;

  @override
  List<Object> get props => [language, wordLength];

  @override
  bool get stringify => true;
}

class SettingsSave extends SettingsEvent {
  const SettingsSave();

  @override
  List<Object> get props => [];
}
