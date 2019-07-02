import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lust/widgets/utils/oneLineText.dart';
import 'package:lust/models/library.dart';
import 'package:lust/models/trend.dart';
import 'package:after_layout/after_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CapacityInfo extends StatefulWidget {
  CapacityInfo();

  _CapacityInfoState createState() => _CapacityInfoState();
}




class _CapacityInfoState extends State<CapacityInfo> {//with AfterLayoutMixin<CapacityInfo> {

  String occupancyLib;
  String totalSeatsLib;
  Library lib;
  StreamSubscription<DocumentSnapshot> streamSub;
  StreamSubscription<QuerySnapshot> eventSub;
  Map<String, int> occupancy = Map();

  var dbLibraryCollectionReference = Firestore.instance.collection('lib_test');
  var eventList = Firestore.instance.collection("events");

  _CapacityInfoState() {
    lib = Library();
    occupancyLib = "...";
    totalSeatsLib = "...";

    var eventSnapshots = eventList.orderBy("time", descending: false).where(
        "time",
        isGreaterThan: DateTime.utc(
            DateTime
                .now()
                .year, DateTime
            .now()
            .month, DateTime
            .now()
            .day)).snapshots();


    streamSub =
        dbLibraryCollectionReference.document('centralHM').snapshots().listen((
            DocumentSnapshot ds) => fillLib(ds));

    eventSub = eventSnapshots.listen((QuerySnapshot snapshot) =>
        calculateOccupancy(snapshot, lib));
  }

  var _icons = const [Icons.arrow_upward, Icons.arrow_forward, Icons.arrow_downward];
  var _colors = const [Colors.red, Colors.orange, Colors.green];

  String _buildOpeningClosingHour(Library lib) {
    // opening time
    String openingTime = "";
    int openingHour = lib.openingTimeToday.hour;
    int openingMin = lib.openingTimeToday.minute;

    openingHour < 10
        ? openingTime = openingTime + "0" + openingHour.toString()
        : openingTime = openingTime + openingHour.toString();
    openingTime = openingTime + ":";
    openingMin < 10
        ? openingTime = openingTime + "0" + openingMin.toString()
        : openingTime = openingTime + openingMin.toString();


    // closing time
    String closingTime = "";
    int closingHour = lib.closingTimeToday.hour;
    int closingMin = lib.closingTimeToday.minute;

    closingHour < 10
        ? closingTime = closingTime + "0" + closingHour.toString()
        : closingTime = closingTime + closingHour.toString();
    closingTime = closingTime + ":";
    closingMin < 10
        ? closingTime = closingTime + "0" + closingMin.toString()
        : closingTime = closingTime + closingMin.toString();

    return openingTime + " - " + closingTime;
  }

  @override
  Widget build(BuildContext context) {
    double dividerHeight = 1.0;
    double dividerIndent = 0.0;
    Color dividerColor = Colors.black;


    // getting the current even hour

    occupancyLib = lib.currentFilling.toString();

    totalSeatsLib = lib.totalSeats.toString();


    return new Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              OneLineText(text: "Occupancy current/total:"),
              OneLineText(text: occupancyLib + "/" + totalSeatsLib),
            ],
          ),
          new Divider(
            height: dividerHeight,
            indent: dividerIndent,
            color: dividerColor,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              OneLineText(text: "Estimated trend:"),
              new Icon(
                _icons[Trend.leveling.index], // TODO is that good?
                color: _colors[Trend.leveling.index],
              ),
            ],
          ),
          new Divider(
            height: dividerHeight,
            indent: dividerIndent,
            color: dividerColor,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              OneLineText(text: "Opening hours:"),
              OneLineText(
                text: _buildOpeningClosingHour(lib),
              ),
            ],
          ),
        ],
      ),
    );
  }


  void fillLib(DocumentSnapshot ds) {
    Map<String, dynamic> libraryData = ds.data;

    if (libraryData.isNotEmpty) {
      lib.setDataFromMap(libraryData);
    }
  }

  void calculateOccupancy(QuerySnapshot qs, Library lib) {
    if (qs.documents.isNotEmpty) {
      List<Event> events = qs.documents.map((DocumentSnapshot ds) =>
          Event.fromMap(ds.data)).toList();

      int usersIn = 0;

      Map<String, int> occupancyMap = Map();

      int currentKey = 0; // TODO opening time

      for (var event in events) {
        if (currentKey != event.getEvenHour())
          currentKey = event.getEvenHour();

        if (event.type == "login") {
          usersIn += 1;
        } else {
          usersIn -= 1;
        }
        occupancyMap[currentKey.toString()] = usersIn;
      }

      setState(() {
        lib.occupancyMap = occupancyMap;
      });
    }
  }


//  void setData(DocumentSnapshot ds) {
//    String occupancy;
//    String totalSeats;
//    // use ds as a snapshot
//    if (ds.data.isEmpty) {
//      occupancyLib = "...";
//      totalSeatsLib = "...";
//    }
//    occupancy = occupancyLib = ds.data['occupancy'].toString();
//    totalSeats = totalSeatsLib = ds.data['totalseats'].toString();
//    if (context != null) {
//      setState(() {
//        //occupancyLib = widget;
//        occupancyLib = occupancy;
//        totalSeatsLib = totalSeats;
//      });
//    }
//  }
}


class Event {
  DateTime time;
  String type;

  Event();

  Event.fromMap(Map<String, dynamic> map){
    time = DateTime.fromMillisecondsSinceEpoch(map["time"].seconds * 1000);
    type = map["eventType"];
  }

  int getEvenHour() {
    num hour = time.hour;
    if (hour % 2 != 0)
      hour -= 1;

    return hour;
  }

}