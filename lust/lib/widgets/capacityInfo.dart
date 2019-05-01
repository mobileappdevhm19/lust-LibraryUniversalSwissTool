import 'package:flutter/material.dart';

class CapacityInfo extends StatefulWidget {
  _CapacityInfoState createState() => _CapacityInfoState();
}

class _CapacityInfoState extends State<CapacityInfo> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Text(
              "Occupancy current/total: 65/123",
            style: new TextStyle(
                fontSize: 20.0, letterSpacing: 2.0
            ),
          ),
          new Divider(height: 30.0, indent: 0.0, color: Colors.black,),
          new Text(
            "Estimated trend: ",
            style: new TextStyle(
                fontSize: 20.0, letterSpacing: 2.0
            ),
          ),
          new Divider(height: 30.0, indent: 0.0, color: Colors.black,),
          new Text(
            "Opening hours today: 8:00 - 23:00",
            style: new TextStyle(
                fontSize: 20.0, letterSpacing: 2.0
            ),
          ),
          //new Divider(height: 40.0, indent: 0.0,)
        ],
      ),
    );
  }

}