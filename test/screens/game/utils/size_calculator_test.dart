import 'package:flutter_test/flutter_test.dart';
import 'package:letamind/screens/game/utils/size_data.dart';

void main() {
  group('size calculator', () {
    test('basics', () {
      expect(SizeData.create(length: 4, width: 414).padding, 4);
    });
  });
}
