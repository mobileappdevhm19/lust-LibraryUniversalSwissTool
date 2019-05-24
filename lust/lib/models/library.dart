import 'package:lust/models/percentPerHour.dart';

class Library {
// interface
  DateTime _openingTimeToday;
  DateTime _closingTimeToday;

  List<PercentPerHour> _occupancyPerHour;

  Library();

  /// creates a library with sample data
  Library.withSampleData() {
    _occupancyPerHour = [
      PercentPerHour(17, "8"),
      PercentPerHour(35, "10"),
      PercentPerHour(13, "12"),
      PercentPerHour(7, "14"),
      PercentPerHour(22, "16"),
      PercentPerHour(42, "18"),
      PercentPerHour(87, "20"),
      PercentPerHour(69, "22"),
    ];

    _closingTimeToday = DateTime(2019, 1, 1, 24);
    _openingTimeToday = DateTime(2019, 1, 1, 8);
  }

  /// Gives you the opening time today.
  /// Checks the current date and if the day is not today it ask of the new
  /// opening time for the current day
  DateTime getOpeningTimeToday() {
    return _openingTimeToday;
  }

  /// Gives you the closing time today
  /// checks the current date and if the day is not today it ask of the new
  /// opening time for the current day
  DateTime getClosingTimeToday() {
    return _closingTimeToday;
  }

  /// Compares the given DateTime and gives out an array of opening ours between
  /// the opening our and the closing our.
  List<PercentPerHour> getOccupancyPercentPerHour(DateTime date) {
    return _occupancyPerHour;
  }
}
