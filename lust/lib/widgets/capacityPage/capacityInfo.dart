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

  String _buildOpeningClosingHour(Library lib) {
    String openingTime = "";
    int openingHour = lib
        .getOpeningTimeToday()
        .hour;
    int openingMin = lib
        .getOpeningTimeToday()
        .minute;

    openingHour < 10
        ? openingTime = openingTime + "0" + openingHour.toString()
        : openingTime = openingTime + openingHour.toString();
    openingTime = openingTime + ":";
    openingMin < 10
        ? openingTime = openingTime + "0" + openingMin.toString()
        : openingTime = openingTime + openingMin.toString();

    String closingTime = "";
    int closingHour = lib
        .getClosingTimeToday()
        .hour;
    int closingMin = lib
        .getClosingTimeToday()
        .minute;

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
              OneLineText(
                  text: stateLibrary.getCurrentFilling().toString() +
                      "/" +
                      stateLibrary.getMaxCapacity().toString()),
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
}
