import 'package:letamind/data/settings.dart';

class Dictionary {
  const Dictionary({this.language, this.words});
  final Language language;
  final List<String> words;
}

abstract class DictionaryProvider {
  Future<Dictionary> provide(Language language);
}

class WordProvider {
  Dictionary dictionary;

  Language get language => dictionary.language;

  String random(int length) =>
      (dictionary.words.where((e) => e.length == length).toList()..shuffle())
          .first;
}
