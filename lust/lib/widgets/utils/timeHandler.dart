/// A class to provide the even current hour.
/// That means it provide the last current hour.

class TimeHandler {
  /// Getting the last even hour. E.g. for 7:42 it will return 6.
  static int makeHourEven(num hour) {
    if (hour < 0 || hour > 24)
      throw new ArgumentError(
          "The input is below 0 or above 24. That's not possible");
    return hour % 2 == 0 ? hour : hour - 1;
  }
}
