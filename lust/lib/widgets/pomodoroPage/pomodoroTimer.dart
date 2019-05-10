import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';

enum Status{
  nothing, learning, shortBreak, longBreak
}

//like struct in c++
class statusClass {
  final int time;
  final String text;
  const statusClass(this.time, this.text);
}

class PomodoroTimer extends StatefulWidget {
  _PomodoroTimerState ptS;
  PomodoroTimer(int periodTime, int shortBreakTime, int longBreakTime, int countPeriods) {
      ptS=new _PomodoroTimerState(periodTime, shortBreakTime, longBreakTime, countPeriods);
  }

  @override
  _PomodoroTimerState createState() => ptS;
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  List<statusClass> statuslist=new List();
  int countPeriods;

  int actPeriod=0;
  int actTimerSeconds=0;
  String actTimeMinutesSeconds="";
  Status actStatus=Status.nothing; //initial
  String actStatusText="";

  Timer _timer;


  _PomodoroTimerState(int periodTime, int shortBreakTime, int longBreakTime, int countPeriods) {
    statuslist.add(statusClass(-1, ""));
    statuslist.add(statusClass(periodTime, "actual you have to learn!"));
    statuslist.add(statusClass(shortBreakTime, "make a short break"));
    statuslist.add(statusClass(longBreakTime, "make a long break"));

    this.countPeriods = countPeriods;
  }


  @override
  Widget build(BuildContext context) {
    return new Align(
        alignment: Alignment.center,
        child: Container(
          child: Column(
            children: <Widget>[
              RaisedButton(
                onPressed: () {buttonClicked();},
                child: const Text(
                    'Button',
                    style: TextStyle(fontSize: 20)
                ),
              ),

               Container(
               // color: Colors.blue,
                width: MediaQuery.of(context).size.width, //screen width
                height: 200.0,
                child: FittedBox(
                  fit: BoxFit.contain,
                    child: Text(
                      "$actTimeMinutesSeconds",
                      textScaleFactor: 0.8,
                      style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
                      textAlign: TextAlign.center,
                    )
                ),
              ),
              Expanded(child: Text(
                "$actStatusText",
                textScaleFactor: 0.8,
                style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
                textAlign: TextAlign.center,
              )),
            ],
         ),
        ),
    );
  }

  void buttonClicked(){
    if(actStatus== Status.nothing){
      changeStatus();
    }
    else{

    }
  }

  ///
  /// starts timer
  /// set description Status text

  void changeStatus(){

    //necessary, otherwise multiple timer instances interfere each other
    actTimerSeconds=0;
    if(_timer !=null){
      _timer.cancel();
    }
    switch(actStatus){
      case Status.learning: {
        if(actPeriod>=countPeriods){
          actStatus=Status.longBreak;
          actPeriod=0; //start counting periods new
        }
        else{
          actStatus=Status.shortBreak;
        }
        break;
      }
      default: {
        actStatus=Status.learning;
        actPeriod++;
      }
    }


    actTimerSeconds=statuslist[actStatus.index].time;

    actStatusText=descriptionText();

    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
        oneSec,
            (Timer timer) => setState(() {
          if (actTimerSeconds < 1) {
            //timer.cancel();
            changeStatus();
          } else {
            actTimerSeconds --;
            setActTimeMinutesSeconds();
          }
        }));
  }

  void setActTimeMinutesSeconds(){
    int minutes=(actTimerSeconds/60).toInt();
    String minutesStirng=setFirst0(minutes);
    String secondsString=setFirst0(actTimerSeconds-(minutes*60));

    actTimeMinutesSeconds="$minutesStirng : $secondsString";
  }
  String setFirst0(int number){
    if(number<10){
      return "0$number";
    }
    else{
      return number.toString();
    }
  }

  String descriptionText(){
    String ret=statuslist[actStatus.index].text;
    ret +="\n";
    ret +=(countPeriods-actPeriod).toString() +"periods till next long break";
    return ret;
  }
}