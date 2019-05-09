import 'package:flutter/material.dart';

class pomodoroDescription extends StatelessWidget {
  double periodTime;
  double shortBreakTime;
  double longBreakTime;
  int countPeriods;

  pomodoroDescription(double periodTime, double shortBreakTime, double longBreakTime, int countPeriods){
    this.periodTime=periodTime;
    this.shortBreakTime=shortBreakTime;
    this.longBreakTime=longBreakTime;
    this.countPeriods=countPeriods;
  }


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
                Expanded(child: Text(
                  "$periodTime min",
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
                Expanded(child: Text(
                  "$shortBreakTime min"+" / "+"$longBreakTime min",
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
                Expanded(child: Text(
                  '$countPeriods',
                  textScaleFactor: 0.8,
                  style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
                  textAlign: TextAlign.center,
                )),
              ],
            ),
            new SizedBox(
              height: 10.0,
              child: new Center(
                child: new Container(
                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 5.0,
                  color: Colors.red,
                ),
              ),
            )
          ]),
    );

  }

}
