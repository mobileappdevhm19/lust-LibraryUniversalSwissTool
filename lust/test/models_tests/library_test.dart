import 'package:flutter_test/flutter_test.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lust/models/library.dart';
import 'package:lust/models/trend.dart';

void main() {
  GeoPoint point = GeoPoint(400000, 110000);

  test('Create a library with lon and lat', () {

    // Create a library
    Library lib = new Library.withLocation(point);

    // Check if the values have been set
    expect(lib.location, point);
  });

  test('Create a library with sample data', () {

    // Values to check for
    int opening = 1;
    int closingHour = 1;
    int closingMinute = 8;

    int currentFilling = 60;
    int maxCapacity = 120;

    String address = "TestAdress";
    String name = "HMBib";
    Timestamp openingTime = Timestamp.fromMillisecondsSinceEpoch(100000);
    Timestamp closingTime = Timestamp.fromMillisecondsSinceEpoch(500000);

    Map<String, dynamic> testData = {
      'address': address,
      'location': point,
      'name': name,
      'totalseats': maxCapacity,
      'openingTime': openingTime,
      'closingTime': closingTime,
    };

    // Create a library
    Library lib = new Library();
    lib.setDataFromMap(testData);

    // Check for the opening time
    print("Opens at: " + lib.openingTimeToday.hour.toString());
    expect(lib.openingTimeToday.hour, opening);

    // Check for the closing time
    print("Closes at: " + lib.closingTimeToday.hour.toString()+ ":" + lib.closingTimeToday.minute.toString());
    expect(lib.closingTimeToday.hour, closingHour);
    expect(lib.closingTimeToday.minute, closingMinute);

    // Check for the current filling
    //print("Current filling: " + lib.currentFilling.toString());
    //expect(lib.currentFilling, currentFilling);

    // Check for the maximum capacity
    print("Max Cap: " + lib.totalSeats.toString());
    expect(lib.totalSeats, maxCapacity);
  });
}