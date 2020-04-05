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
  const UpdateSettings({this.language, this.wordLength});
  final Language language;
  final int wordLength;

  @override
  List<Object> get props => [language, wordLength];

  @override
  bool get stringify => true;
}

class SaveSettings extends SettingsEvent {
  const SaveSettings();

  @override
  List<Object> get props => [];
}
