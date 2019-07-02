import 'package:cloud_firestore/cloud_firestore.dart';

class Library {
// interface
  GeoPoint _location;

  DateTime _openingTimeToday;
  DateTime _closingTimeToday;
  String _address;
  int _currentFilling;
  Map<String, int> _occupancyMap = Map();
  String _name;
  int _totalSeats;


  set occupancyMap(Map<String, int> value) {
    _occupancyMap = value;
  }

  DateTime get openingTimeToday => _openingTimeToday;

  Map<String, int> get occupancyMap => _occupancyMap;

  GeoPoint get location => _location;

  String get name => _name;

  DateTime get closingTimeToday => _closingTimeToday;

  String get address => _address;

  int get currentFilling {
    return occupancyMap[_occupancyMap.keys
        .toList()
        .last];
  }

  int get totalSeats => _totalSeats;

  Library() {
    _occupancyMap["8"] = 0;
    _occupancyMap["10"] = 0;
    _occupancyMap["12"] = 0;
    _occupancyMap["14"] = 0;
    _occupancyMap["16"] = 0;
    _occupancyMap["18"] = 0;
    _occupancyMap["20"] = 0;
    _occupancyMap["22"] = 0;

    _openingTimeToday = DateTime(DateTime
        .now()
        .year, DateTime
        .now()
        .month, DateTime
        .now()
        .day, 0, 1);
    _closingTimeToday = DateTime(DateTime
        .now()
        .year, DateTime
        .now()
        .month, DateTime
        .now()
        .day, 23, 59);
  }

  Library.withLocation(this._location);

  void setDataFromMap(Map<String, dynamic> map) {
    this._address = map["address"];
    this._openingTimeToday =
        DateTime.fromMillisecondsSinceEpoch(map["openingTime"].seconds * 1000);
    this._closingTimeToday =
        DateTime.fromMillisecondsSinceEpoch(map["closingTime"].seconds * 1000);
    this._location = map["location"];
    this._name = map["name"];
    this._totalSeats = map["totalseats"];
  }

}
