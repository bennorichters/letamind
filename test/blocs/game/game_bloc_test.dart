import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:letamind/blocs/game/game_bloc.dart';
import 'package:letamind/data/settings.dart';
import 'package:letamind/data/word_provider.dart';
import 'package:mockito/mockito.dart';

class MockSettingsProvider extends Mock implements SettingsProvider {}

class TestWordProvider implements WordProvider {
  @override
  String random(int length) => '1234567890'.substring(0, length);
}

void main() {
  group('game bloc', () {
    SettingsProvider settingsProvider;
    WordProvider wordProvider = TestWordProvider();

    final testSettings = Settings(language: Language.Dutch, wordLength: 5);

    setUp(() {
      settingsProvider = MockSettingsProvider();
      when(settingsProvider.provide())
          .thenAnswer((_) => Future.value(testSettings));
    });

    blocTest(
      'inital state',
      build: () async => GameBloc(
        settingsProvider: settingsProvider,
        wordProvider: wordProvider,
      ),
      skip: 0,
      expect: [GameState(word: null, moves: [], finished: false)],
    );
  });
}
