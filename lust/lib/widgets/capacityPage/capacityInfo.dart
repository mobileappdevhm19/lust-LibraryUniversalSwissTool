import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lust/widgets/utils/oneLineText.dart';
import 'package:lust/models/library.dart';

import 'package:after_layout/after_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CapacityInfo extends StatefulWidget {
  final Library widgetLibrary;

  CapacityInfo(this.widgetLibrary);

  factory CapacityInfo.withSampleData() {
    Library lib = Library.withSampleData();
    return CapacityInfo(lib);
  }

  _CapacityInfoState createState() => _CapacityInfoState(widgetLibrary);
}

class _CapacityInfoState extends State<CapacityInfo> with AfterLayoutMixin<CapacityInfo> {
  Library stateLibrary;

  var dbLibraryCollectionReference;

  StreamSubscription<DocumentSnapshot> streamSub;

  String occupancyLib;
  String totalSeatsLib;

  _CapacityInfoState(this.stateLibrary) {
    dbLibraryCollectionReference = Firestore.instance.collection('lib_test');
    occupancyLib = "...";
    totalSeatsLib = "...";

    streamSub = dbLibraryCollectionReference.document('centralHM').snapshots().listen((DocumentSnapshot ds) => setData(ds));
  }

  var _icons = const [Icons.arrow_upward, Icons.arrow_forward, Icons.arrow_downward];
  var _colors = const [Colors.red, Colors.orange, Colors.green];

  String _buildOpeningClosingHour(Library lib) {
    String openingTime = "";
    int openingHour = lib.getOpeningTimeToday().hour;
    int openingMin = lib.getOpeningTimeToday().minute;

    openingHour < 10
        ? openingTime = openingTime + "0" + openingHour.toString()
        : openingTime = openingTime + openingHour.toString();
    openingTime = openingTime + ":";
    openingMin < 10
        ? openingTime = openingTime + "0" + openingMin.toString()
        : openingTime = openingTime + openingMin.toString();

    String closingTime = "";
    int closingHour = lib.getClosingTimeToday().hour;
    int closingMin = lib.getClosingTimeToday().minute;

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
                _icons[stateLibrary.getEstimatedTrend().index], // TODO is that good?
                color: _colors[stateLibrary.getEstimatedTrend().index],
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
                text: _buildOpeningClosingHour(stateLibrary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // needs to be overritten to get AfterLayoutMixin<CapacityInfo> functionality
  // -> set state new after drawing
  @override
  void afterFirstLayout(BuildContext context) {
  }

  void setData(DocumentSnapshot ds) {
    String occupancy;
    String totalSeats;
    // use ds as a snapshot
    if (ds.data.isEmpty) {
      occupancyLib = "...";
      totalSeatsLib = "...";
    }
    occupancy = occupancyLib = ds.data['occupancy'].toString();
    totalSeats = totalSeatsLib = ds.data['totalseats'].toString();
    setState(() {
      //occupancyLib = widget;
      occupancyLib = occupancy;
      totalSeatsLib = totalSeats;
    });
  }
}