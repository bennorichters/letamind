abstract class WordProvider {
  String random(int length);
}

class DictionaryWordProvider implements WordProvider {
  DictionaryWordProvider(this.words);
  final List<String> words;

  @override
  String random(int length) =>
      (words.where((e) => e.length == length).toList()..shuffle()).first;
}
