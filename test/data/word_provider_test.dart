import 'package:flutter_test/flutter_test.dart';
import 'package:letamind/data/word_provider.dart';

void main() {
  group('word provider', () {

    test('right length', (){
      WordProvider provider = DictionaryWordProvider(['1234','12345']);
      expect(provider.random(4), '1234');
      expect(provider.random(5), '12345');
    });
  });
}
