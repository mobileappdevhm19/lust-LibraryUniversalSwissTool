import 'package:flutter_test/flutter_test.dart';
import 'package:lust/models/occupancyPerHour.dart';

void main() {
  test("ConstructorTest", () {
    final pPH = OccupancyPerHour(1, "2");

    expect(pPH.hour, "2");
    expect(pPH.percent, 1);
  });
}