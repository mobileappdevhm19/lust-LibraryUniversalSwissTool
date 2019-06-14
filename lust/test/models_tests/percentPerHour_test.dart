import 'package:flutter_test/flutter_test.dart';
import 'package:lust/models/percentPerHour.dart';

void main() {
  test("ConstructorTest", () {
    final pPH = PercentPerHour(1, "2");

    expect(pPH.hour, "2");
    expect(pPH.percent, 1);
  });
}