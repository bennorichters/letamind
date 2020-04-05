import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:letamind/data/settings.dart';
import 'package:mockito/mockito.dart';

import 'package:letamind/blocs/settings/settings_bloc.dart';

class MockSettingsProvider extends Mock implements SettingsProvider {}

void main() {
  group('settings bloc', () {
    final testSettings = Settings(language: 'a', wordLength: 1);
    SettingsProvider provider;

    setUp(() {
      provider = MockSettingsProvider();
      when(provider.provide()).thenAnswer(
        (_) => Future.value(
          Settings(language: 'a', wordLength: 1),
        ),
      );
    });

    blocTest(
      'inital state has null settings',
      build: () async => SettingsBloc(provider),
      skip: 0,
      expect: [SettingsState(null)],
    );

    blocTest(
      'update emit same settings',
      build: () async => SettingsBloc(provider),
      act: (bloc) => bloc.add(UpdateSettings(testSettings)),
      expect: [SettingsState(testSettings)],
    );

    blocTest(
      'save triggers provider save and emit same settings',
      build: () async => SettingsBloc(provider),
      act: (bloc) => bloc.add(SaveSettings(testSettings)),
      expect: [SettingsState(testSettings)],
      verify: (_) async {
        verify(provider.save(testSettings)).called(1);
      },
    );
  });
}
