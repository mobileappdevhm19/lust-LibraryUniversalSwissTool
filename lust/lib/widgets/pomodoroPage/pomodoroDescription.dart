import 'package:flutter/material.dart';
import 'package:lust/pages/pomodoroPage.dart';


class pomodoroDescription extends StatelessWidget {
  int periodTime;
  int shortBreakTime;
  int longBreakTime;
  int countPeriods;
  PomodoroState pomPage;


  TextEditingController  periodTimeController;
  TextEditingController  periodCountController;

  TextEditingController  shortBreakController;
  TextEditingController  longBreakController;

  pomodoroDescription(){
    periodTimeController = new TextEditingController();
    periodCountController = new TextEditingController();

    shortBreakController = new TextEditingController();
    longBreakController = new TextEditingController();
  }

  void setValues(int periodTime, int shortBreakTime, int longBreakTime, int countPeriods, PomodoroState pomPage){
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
                  TextField(
                    decoration: new InputDecoration(labelText: "time [min]", ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold),
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
                        decoration: new InputDecoration(labelText: "count", ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold),
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
                      TextField(
                        decoration: new InputDecoration(labelText: "short [min]", ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold),
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
                        decoration: new InputDecoration(labelText: "long [min]", ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold),
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
    pomPage.updateVales(periodTime, shortBreakTime, longBreakTime, countPeriods);
  }

}
