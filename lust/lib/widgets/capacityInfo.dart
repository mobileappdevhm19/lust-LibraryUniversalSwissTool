import 'package:flutter/material.dart';

class CapacityInfo extends StatefulWidget {
  _CapacityInfoState createState() => _CapacityInfoState();
}

class _CapacityInfoState extends State<CapacityInfo> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Text(
              "Test1",
            style: new TextStyle(
                fontSize: 30.0, color: Colors.red, letterSpacing: 2.0
            ),
          ),
        ],
      ),
    );
  }

}