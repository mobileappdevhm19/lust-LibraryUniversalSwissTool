import 'package:flutter/material.dart';
import 'package:lust/models/capacity/trend.dart';

class CapacityInfo extends StatefulWidget {
  _CapacityInfoState createState() => _CapacityInfoState();
}

class _CapacityInfoState extends State<CapacityInfo> {
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
              new Text(
                "Occupancy current/total:",
                style: new TextStyle(fontSize: 20.0, letterSpacing: 2.0),
                textScaleFactor: 0.8,
              ),
              new Text(
                getFillingAbsolute().toString() + "/" + getMaxCapacity().toString(),
                style: new TextStyle(fontSize: 20.0, letterSpacing: 2.0),
                textScaleFactor: 0.8,
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
              new Text(
                "Estimated trend:",
                style: new TextStyle(fontSize: 20.0, letterSpacing: 2.0),
                textScaleFactor: 0.8,
              ),
              new Icon(
                _icons[getEstimatedTrend().index],
                color: _colors[getEstimatedTrend().index],
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
              new Text(
                "Opening hours today:",
                style: new TextStyle(fontSize: 20.0, letterSpacing: 2.0),
                textScaleFactor: 0.8,
              ),
              new Text(
                getOpeningHoursFormatted(),
                style: new TextStyle(fontSize: 20.0, letterSpacing: 2.0,),
                textScaleFactor: 0.8,
              ),
            ],
          ),
          //new Divider(height: 40.0, indent: 0.0,)
        ],
      ),
    );
  }

  String getOpeningHoursFormatted(){
    int open = 8;
    int close = 23;
    return "$open:00 - $close:00";
  }

  Trend getEstimatedTrend() {
    Trend trend = Trend.rising;
    return trend;
  }

  int getFillingAbsolute() {
    int fillingAbsolute = 60;
    return fillingAbsolute;
  }

  int getMaxCapacity() {
    int maxCap = 120;
    return maxCap;
  }
}
