import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';

enum Status{
  nothing, learning, shortBreak, longBreak
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
  List<int> statuslist=new List();
  int countPeriods;

  int actPeriod=0;
  int actTimerSeconds=0;
  Status actStatus=Status.nothing; //initial

  Timer _timer;


  _PomodoroTimerState(int periodTime, int shortBreakTime, int longBreakTime, int countPeriods) {
    statuslist.add(-1);
    statuslist.add(periodTime);
    statuslist.add(shortBreakTime);
    statuslist.add(longBreakTime);

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

              Expanded(child: Text(
                "$actTimerSeconds sec",
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
      changeStatusStartTimer();
    }
    else{

    }
  }

  void changeStatusStartTimer(){

    switch(actStatus){
      case Status.learning: {
        if(actPeriod<=countPeriods){
          actStatus=Status.shortBreak;
        }
        else{
          actStatus=Status.longBreak;
          actPeriod=0; //start counting periods new
        }
        break;
      }
      default: {
        actStatus=Status.learning;
        actPeriod++;
      }
    }


    actTimerSeconds=statuslist[actStatus.index];
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
        oneSec,
            (Timer timer) => setState(() {
          if (actTimerSeconds < 1) {
            //timer.cancel();
            changeStatusStartTimer();
          } else {
            actTimerSeconds --;
          }
        }));
  }
}