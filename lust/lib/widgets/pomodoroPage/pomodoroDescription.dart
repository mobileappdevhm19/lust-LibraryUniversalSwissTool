import 'package:flutter/material.dart';

class pomodoroDescription extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Row(
              children: <Widget>[
                const Expanded(child: Text(
                  "period:",
                  textScaleFactor: 0.8,
                  style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
                  textAlign: TextAlign.center,
                )),
                const Expanded(child: Text(
                  "25.5 min",
                  textScaleFactor: 0.8,
                  style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
                  textAlign: TextAlign.center,
                )),
              ],
            ),
            new Divider(
              height: 50.0,
              indent: 0.0,
              color: Colors.black,
            ),
            new Row(
              children: <Widget>[
                const Expanded(child: Text(
                  "break:",
                  textScaleFactor: 0.8,
                  style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
                  textAlign: TextAlign.center,
                )),
                const Expanded(child: Text(
                  "5 / 15 min",
                  textScaleFactor: 0.8,
                  style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
                  textAlign: TextAlign.center,
                )),
              ],
            ),
            new Divider(
              height: 50.0,
              indent: 0.0,
              color: Colors.black,
            ),
            new Row(
              children: <Widget>[
                const Expanded(child: Text(
                  "periods:",
                  textScaleFactor: 0.8,
                  style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
                  textAlign: TextAlign.center,
                )),
                const Expanded(child: Text(
                  "4",
                  textScaleFactor: 0.8,
                  style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
                  textAlign: TextAlign.center,
                )),
              ],
            ),
          ]),
    );

  }

}
