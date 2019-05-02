import 'package:flutter/material.dart';
import 'package:lust/models/capacity/trend.dart';

class CapacityInfo extends StatefulWidget {
  _CapacityInfoState createState() => _CapacityInfoState();
}

class _CapacityInfoState extends State<CapacityInfo> {
  int dummyData = 65;
  String dummyTime = "8:00 - 23:00";
  Trend trend = Trend.rising;
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
              ),
              new Text(
                dummyData.toString() + "/133",
                style: new TextStyle(fontSize: 20.0, letterSpacing: 2.0),
              ),
            ],
          ),
          new Divider(
            height: 30.0,
            indent: 0.0,
            color: Colors.black,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text(
                "Estimated trend:",
                style: new TextStyle(fontSize: 20.0, letterSpacing: 2.0),
              ),
              new Icon(
                _icons[trend.index],
                color: _colors[trend.index],
              ),
            ],
          ),
          new Divider(
            height: 30.0,
            indent: 0.0,
            color: Colors.black,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text(
                "Opening hours today:",
                style: new TextStyle(fontSize: 20.0, letterSpacing: 2.0),
              ),
              new Text(
                dummyTime,
                style: new TextStyle(fontSize: 20.0, letterSpacing: 2.0),
              ),
            ],
          ),
          //new Divider(height: 40.0, indent: 0.0,)
        ],
      ),
    );
  }
}
