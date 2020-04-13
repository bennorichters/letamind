import 'package:flutter_test/flutter_test.dart';
import 'package:letamind/screens/game/utils/size_calculator.dart';

void main() {
  group('size calculator', () {
    test('basics', () {
      expect(SizeCalculator.create(length: 4, width: 414).padding, 4);
    });
  });
}
