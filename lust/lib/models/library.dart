import 'package:lust/models/percentPerHour.dart';
import 'package:lust/models/trend.dart';

class Library {
// interface
  DateTime _openingTimeToday;
  DateTime _closingTimeToday;

  int _fillingAbsolute;
  int _maxCapacity;

  List<PercentPerHour> _occupancyPerHour;

  Library();

  /// creates a library with sample data
  Library.withSampleData() {
    // Set the Opening hour to today 8:00 and closing to 24
    _closingTimeToday = DateTime(DateTime
        .now()
        .year, DateTime
        .now()
        .month, DateTime
        .now()
        .day, 24);
    _openingTimeToday = DateTime(DateTime
        .now()
        .year, DateTime
        .now()
        .month, DateTime
        .now()
        .day, 8);

    _occupancyPerHour = [
      PercentPerHour(17, "8"),
      PercentPerHour(35, "10"),
      PercentPerHour(13, "12"),

      PercentPerHour(7, "14"),
      PercentPerHour(22, "16"),
      PercentPerHour(50, "18"),

      PercentPerHour(87, "20"),
      PercentPerHour(69, "22"),
    ];


    _fillingAbsolute = 60;
    _maxCapacity = 120;
  }

  /// Gives you the opening time today.
  /// Checks the current date and if the day is not today it ask of the new
  /// opening time for the current day
  DateTime getOpeningTimeToday() {
    // TODO get the time from firebase
    return _openingTimeToday;
  }

  /// Gives you the closing time today
  /// checks the current date and if the day is not today it ask of the new
  /// opening time for the current day
  DateTime getClosingTimeToday() {
    // TODO get the time from firebase
    return _closingTimeToday;
  }

  /// Compares the given DateTime and gives out an array of opening ours between
  /// the opening our and the closing our.
  getOccupancyPercentPerHour(DateTime date) {
    return _occupancyPerHour;
  }


  // Calculate the trend by comparing the current occupancy percent with the last
  Trend getEstimatedTrend() {
    int threshold = 3;

    Trend trend;
    int durationHours = DateTime
        .now()
        .difference(getOpeningTimeToday())
        .inHours;

    if (durationHours ~/ 2 <= 0)
      trend = Trend.rising;
    else {
      int previousPercent = _occupancyPerHour
          .elementAt(durationHours ~/ 2 - 1)
          .percent;
      int currentPercent = _occupancyPerHour
          .elementAt(durationHours ~/ 2)
          .percent;

      int trendIndex = currentPercent - previousPercent;

      trendIndex < -threshold ? trend = Trend.falling :
      trendIndex > threshold ? trend = Trend.rising :
      trend = Trend.leveling;
    }
    return trend;
  }

  int getCurrentNumberStudentsIn() {
    return _fillingAbsolute;
  }

  int getMaxCapacity() {
    return _maxCapacity;
  }
}
