import 'package:flutter/material.dart';

class pomodoroDescription extends StatelessWidget {
  int periodTime;
  int shortBreakTime;
  int longBreakTime;
  int countPeriods;

  pomodoroDescription(int periodTime, int shortBreakTime, int longBreakTime, int countPeriods){
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
                Expanded(child: new Column(
                    children: <Widget>[
                      Text(
                        "Period",
                        textScaleFactor: 0.8,
                        style: TextStyle(fontSize: 30.0, letterSpacing: 2.0),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                ),
              ],
            ),

            new Row(
              children: <Widget>[
               Expanded(child: new Column(
                children: <Widget>[
                  new TextField(
                    decoration: new InputDecoration(labelText: "time"),
                    keyboardType: TextInputType.number,

                  ),
                ]),
               ),
                Expanded(child: new Column(
                    children: <Widget>[
                      new TextField(
                        decoration: new InputDecoration(labelText: "count"),
                        keyboardType: TextInputType.number,

                      ),
                    ]),
                ),


              ],
            ),

            new Row(
              children: <Widget>[
                Expanded(child: new Column(
                    children: <Widget>[
                      Text(
                        "Break",
                        textScaleFactor: 0.8,
                        style: TextStyle(fontSize: 30.0, letterSpacing: 2.0),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                ),
              ],
            ),

            new Row(
              children: <Widget>[
                Expanded(child: new Column(
                    children: <Widget>[
                      new TextField(
                        decoration: new InputDecoration(labelText: "short"),
                        keyboardType: TextInputType.number,
                      ),
                    ]),
                ),
                Expanded(child: new Column(
                    children: <Widget>[
                      new TextField(
                        decoration: new InputDecoration(labelText: "long"),
                        keyboardType: TextInputType.number,
                      ),
                    ]),
                ),
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
