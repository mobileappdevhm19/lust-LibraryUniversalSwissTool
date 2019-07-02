import 'dart:async';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lust/models/library.dart';
import 'package:lust/models/occupancyPerHour.dart';
import 'package:lust/widgets/utils/timeHandler.dart';


class CapacityGraph extends StatefulWidget {
  CapacityGraph();

  _CapacityGraphState createState() => _CapacityGraphState();
}


class _CapacityGraphState extends State<CapacityGraph> {

  List<charts.Series<OccupancyPerHour, String>> chartSeries;
  Library lib;
  StreamSubscription<DocumentSnapshot> streamSub;
  StreamSubscription<QuerySnapshot> eventSub;
  Map<String, int> occupancy = Map();

  var dbLibraryCollectionReference = Firestore.instance.collection('lib_test');
  var eventList = Firestore.instance.collection("events");

  _CapacityGraphState() {
    lib = Library();

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

  @override
  void dispose() {
    streamSub?.cancel();
    eventSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    chartSeries = occupancyMapToChartValues(lib.occupancyMap);

//      return new Text(
//        chartSeries.toList().toString()
//      );
    return new charts.BarChart(chartSeries,
        animate: true,
        // Configure the default renderer as a bar renderer.
        defaultRenderer: new charts.BarRendererConfig(
            groupingType: charts.BarGroupingType.grouped, strokeWidthPx: 2.0),
        // Custom renderer configuration for the line series. This will be used for
        // any series that does not define a rendererIdKey.
        customSeriesRenderers: [
          new charts.LineRendererConfig(
            // ID used to link series to this renderer.
              customRendererId: 'customLine')
        ]);
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

  /// Helper method to create the list of chart.Series out of an array of percentPerHour
  static List<
      charts.Series<OccupancyPerHour, String>> occupancyMapToChartValues(
      Map<String, int> map) {
    int lastOccupancy = 0;

    List<OccupancyPerHour> occupancyPerHourList = [];

    occupancyPerHourList = [
      OccupancyPerHour(0, "8"),
      OccupancyPerHour(0, "10"),
      OccupancyPerHour(0, "12"),
      OccupancyPerHour(0, "14"),
      OccupancyPerHour(0, "16"),
      OccupancyPerHour(0, "18"),
      OccupancyPerHour(0, "20"),
      OccupancyPerHour(0, "22"),
    ];

    occupancyPerHourList.forEach((occupancyPerHour) {
      int currentEvenHour = DateTime
          .now()
          .hour
          .isEven ? DateTime
          .now()
          .hour : DateTime
          .now()
          .hour - 1;


      if (int.parse(occupancyPerHour.hour) <= currentEvenHour) {
        if (map.containsKey(occupancyPerHour.hour))
          lastOccupancy = map[occupancyPerHour.hour];
        occupancyPerHour.percent = lastOccupancy;
      }
    });


    final data = occupancyPerHourList;

    var hour = TimeHandler.makeHourEven(DateTime
        .now()
        .hour);

    return [
      new charts.Series<OccupancyPerHour, String>(
        id: 'Other',
        colorFn: (OccupancyPerHour percent, __) =>
        percent.hour == hour.toString()
            ? charts.MaterialPalette.red.shadeDefault
            : charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OccupancyPerHour percent, _) => percent.hour,
        measureFn: (OccupancyPerHour percent, _) => percent.percent,
        data: data,
      ),
    ];
  }
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
