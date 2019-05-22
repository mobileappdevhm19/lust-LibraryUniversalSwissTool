import 'package:flutter/material.dart';
import 'package:lust/widgets/utils/oneLineText.dart';
import 'package:lust/models/library.dart';

class CapacityInfo extends StatefulWidget {
  final Library widgetLibrary;

  CapacityInfo(this.widgetLibrary);

  factory CapacityInfo.withSampleData() {
    Library lib = Library.withSampleData();
    return CapacityInfo(lib);
  }

  _CapacityInfoState createState() => _CapacityInfoState(widgetLibrary);
}

class _CapacityInfoState extends State<CapacityInfo> {
  Library stateLibrary;

  _CapacityInfoState(this.stateLibrary);

  var _icons = const [
    Icons.arrow_upward,
    Icons.arrow_forward,
    Icons.arrow_downward
  ];
  var _colors = const [Colors.red, Colors.orange, Colors.green];

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              OneLineText(text: "Occupancy current/total:"),
              OneLineText(
                  text: stateLibrary.getCurrentFilling().toString() +
                      "/" +
                      stateLibrary.getMaxCapacity().toString()),
            ],
          ),
          new Divider(
            height: 28.0,
            indent: 0.0,
            color: Colors.black,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              OneLineText(text: "Estimated trend:"),
              new Icon(
                _icons[stateLibrary
                    .getEstimatedTrend()
                    .index], // TODO is that good?
                color: _colors[stateLibrary
                    .getEstimatedTrend()
                    .index],
              ),
            ],
          ),
          new Divider(
            height: 28.0,
            indent: 0.0,
            color: Colors.black,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              OneLineText(text: "Opening hours today:"),
              OneLineText(
                  text: stateLibrary
                      .getOpeningTimeToday()
                      .hour
                      .toString() +
                      ":" +
                      stateLibrary
                          .getOpeningTimeToday()
                          .minute
                          .toString() +
                      " - " +
                      stateLibrary
                          .getClosingTimeToday()
                          .hour
                          .toString() +
                      ":" +
                      stateLibrary
                          .getClosingTimeToday()
                          .hour
                          .toString()),
            ],
          ),
          //new Divider(height: 40.0, indent: 0.0,)
        ],
      ),
    );
  }
}
