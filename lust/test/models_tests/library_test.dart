import 'package:flutter_test/flutter_test.dart';

import 'package:lust/models/library.dart';
import 'package:lust/models/trend.dart';

void main() {
  test('Create a library with lon and lat', () {

    // Values to check for
    double latitude = 480000;
    double longitude = 110000;

    // Create a library
    Library lib = new Library(longitude: longitude, latitude: latitude);

    // Check if the values have been set
    expect(lib.latitude, latitude);
    expect(lib.longitude, longitude);
  });

  test('Create a library with sample data', () {

    // Values to check for
    int opening = 8;
    int closing = 0;

    int currentFilling = 60;
    int maxCapacity = 120;

    Trend trend = Trend.falling;

    // Create a library
    Library lib = new Library.withSampleData();

    // Check for the opening time
    //print("Opens at: " + lib.getOpeningTimeToday().hour.toString());
    expect(lib.getOpeningTimeToday().hour, opening);

    // Check for the closing time
    //print("Closes at: " + lib.getClosingTimeToday().hour.toString());
    expect(lib.getClosingTimeToday().hour, closing);

    // Check for the current filling
    //print("Current filling: " + lib.getCurrentFilling().toString());
    expect(lib.getCurrentFilling(), currentFilling);

    // Check for the maximum capacity
    //print("Max Cap: " + lib.getMaxCapacity().toString());
    expect(lib.getMaxCapacity(), maxCapacity);

    // Check for the trend
    //print(lib.getEstimatedTrend().toString());
    expect(lib.getEstimatedTrend(), trend);
  });
}