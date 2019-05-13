import 'package:flutter_test/flutter_test.dart';
import 'package:lust/widgets/utils/timeHandler.dart';
import 'package:matcher/matcher.dart';

void main() {
  group("TimeHandlerTestsCorrectBehavior", () {
    test("TimeHandlerTestEvenHours", () {
      expect(TimeHandler.makeHourEven(0), 0);
      expect(TimeHandler.makeHourEven(2), 2);
      expect(TimeHandler.makeHourEven(4), 4);
      expect(TimeHandler.makeHourEven(6), 6);
      expect(TimeHandler.makeHourEven(8), 8);
      expect(TimeHandler.makeHourEven(10), 10);
      expect(TimeHandler.makeHourEven(12), 12);
      expect(TimeHandler.makeHourEven(14), 14);
      expect(TimeHandler.makeHourEven(16), 16);
      expect(TimeHandler.makeHourEven(18), 18);
      expect(TimeHandler.makeHourEven(20), 20);
      expect(TimeHandler.makeHourEven(22), 22);
    });

    test("TimeHandlerTestOddHours", () {
      expect(TimeHandler.makeHourEven(1), 0);
      expect(TimeHandler.makeHourEven(3), 2);
      expect(TimeHandler.makeHourEven(5), 4);
      expect(TimeHandler.makeHourEven(7), 6);
      expect(TimeHandler.makeHourEven(9), 8);
      expect(TimeHandler.makeHourEven(11), 10);
      expect(TimeHandler.makeHourEven(13), 12);
      expect(TimeHandler.makeHourEven(15), 14);
      expect(TimeHandler.makeHourEven(17), 16);
      expect(TimeHandler.makeHourEven(19), 18);
      expect(TimeHandler.makeHourEven(21), 20);
      expect(TimeHandler.makeHourEven(23), 22);
    });
  });

  group("TimeHandlerException", () {
    test("TimeHandlerUnderFlow", () {
      expect(() => TimeHandler.makeHourEven(-1),
          throwsA(TypeMatcher<ArgumentError>()),
          reason: "makeHourEven(-1)");
      expect(() => TimeHandler.makeHourEven(-9223372036854775808),
          throwsA(TypeMatcher<ArgumentError>()),
          reason: "makeHourEven(-double.maxFinite)"); // min value in int64
    });

    test("TimeHandlerOverFlow", () {
      expect(() => TimeHandler.makeHourEven(25),
          throwsA(TypeMatcher<ArgumentError>()),
          reason: "makeHourEven(25)");
      expect(() => TimeHandler.makeHourEven(9223372036854775807),
          throwsA(TypeMatcher<ArgumentError>()),
          reason: "makeHourEven(double.maxFinite)"); // max value in int64
    });
  });
}
