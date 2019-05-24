import 'package:flutter_test/flutter_test.dart';
import 'package:lust/widgets/utils/timeHandler.dart';
import 'package:matcher/matcher.dart';

void main() {
  test("currentEvenHour", () {
//    expect(TimeHandler.makeHourEven(0), 0);
//    expect(TimeHandler.makeHourEven(11), 10);
//    expect(TimeHandler.makeHourEven(24), 24);
//    expect(ArgumentError("test"), ArgumentError("test"));
    expect(() => throw ArgumentError(), throwsA(TypeMatcher<ArgumentError>()));
    expect(TimeHandler.throwException(), throwsA(TypeMatcher<ArgumentError>()));
  });
}