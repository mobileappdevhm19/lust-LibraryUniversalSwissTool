import 'package:flutter/material.dart';
import 'package:lust/pages/pomodoroPage.dart';


class pomodoroDescription extends StatelessWidget {
  int periodTime;
  int shortBreakTime;
  int longBreakTime;
  int countPeriods;
  PomodoroState pomPage;


  String periodString="period";
  String breakString="break";

  String periodTimeString="time [min]";
  TextEditingController  periodTimeController = new TextEditingController();
  String periodCountString="count";
  TextEditingController  periodCountController = new TextEditingController();

  String shortBreakString="short [min]";
  TextEditingController  shortBreakController = new TextEditingController();
  String longBreakString="long [min]";
  TextEditingController  longBreakController = new TextEditingController();




  TextStyle textFieldStyle=TextStyle(
      fontSize: 20,
      color: Colors.blue,
      fontWeight: FontWeight.bold);

  pomodoroDescription(int periodTime, int shortBreakTime, int longBreakTime, int countPeriods, PomodoroState pomPage){
    this.periodTime=periodTime;
    this.shortBreakTime=shortBreakTime;
    this.longBreakTime=longBreakTime;
    this.countPeriods=countPeriods;
    setValuesToTextFields();
    this.pomPage=pomPage;
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
                        "$periodString",
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
                  TextField(
                    decoration: new InputDecoration(labelText: "$periodTimeString", ),
                    textAlign: TextAlign.center,
                    style: textFieldStyle,
                    keyboardType: TextInputType.number,
                    controller: periodTimeController,
                    onChanged: (text) {
                      periodTime=int.parse(text);
                      updateValues();
                    },
                  ),
                ]),
               ),
                Expanded(child: new Column(
                    children: <Widget>[
                      TextField(
                        decoration: new InputDecoration(labelText: "$periodCountString", ),
                        textAlign: TextAlign.center,
                        style: textFieldStyle,
                        keyboardType: TextInputType.number,
                        controller: periodCountController,
                        onChanged: (text) {
                          countPeriods=int.parse(text);
                          updateValues();
                        },
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
                        "$breakString",
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
                      TextField(
                        decoration: new InputDecoration(labelText: "$shortBreakString", ),
                        textAlign: TextAlign.center,
                        style: textFieldStyle,
                        keyboardType: TextInputType.number,
                        controller: shortBreakController,
                        onChanged: (text) {
                          shortBreakTime=int.parse(text);
                          updateValues();
                        },
                      ),
                    ]),
                ),
                Expanded(child: new Column(
                    children: <Widget>[
                      TextField(
                        decoration: new InputDecoration(labelText: "$longBreakString", ),
                        textAlign: TextAlign.center,
                        style: textFieldStyle,
                        keyboardType: TextInputType.number,
                        controller: longBreakController,
                        onChanged: (text) {
                          longBreakTime=int.parse(text);
                          updateValues();
                        },
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

  //setter for the text fields
  void setValuesToTextFields(){
    periodTimeController.text=periodTime.toString();
    periodCountController.text=countPeriods.toString();

    shortBreakController.text=shortBreakTime.toString();
    longBreakController.text=longBreakTime.toString();
  }


  void updateValues(){
    if(pomPage != null){
      pomPage.updateVales(periodTime, shortBreakTime, longBreakTime, countPeriods);

    }
  }
}
