import 'package:flutter/material.dart';
import 'package:lust/widgets/pomodoroPage/pomodoroDescription.dart';
import 'package:lust/widgets/pomodoroPage/pomodoroTimer.dart';

import 'package:lust/widgets/utils/menuDrawer.dart';


class PomodoroPage extends StatefulWidget {
  static String title = "Pomodoro";
  static IconData icon = Icons.watch;

  @override
  PomodoroState createState() => new PomodoroState(title, icon);
}

class PomodoroState extends State<PomodoroPage> {
  final String title;
  final icon;

  //all in minutes
  int periodTime;
  int shortBreakTime;
  int longBreakTime;
  int countPeriods;

  pomodoroDescription pomDesc;
  PomodoroTimer pomTimer;

  PomodoroState(this.title, this.icon){
    pomodoroDefaultValues();
    pomDesc=new pomodoroDescription(periodTime, shortBreakTime, longBreakTime, countPeriods, this);
    pomTimer= new PomodoroTimer();
    updateVales(periodTime, shortBreakTime, longBreakTime, countPeriods);
    pomTimer.initPomTimerState();
  }

  //set the default values for pomodoro
  void pomodoroDefaultValues(){
    periodTime=10;
    shortBreakTime=4;
    longBreakTime=3;
    countPeriods=9;
  }

  @override
  Widget build(BuildContext context) {

    var _height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(title: Text(title)),
        resizeToAvoidBottomPadding:false, //important, otherwise overlay, when keyboard
        drawer: MenuDrawer.getDrawer(context),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  //height: _height*0.40,
                  child: pomDesc,
                ),
                Expanded(
                  child:pomTimer,
                )
           ]),
        ));
  } // build

  void updateVales(int periodTime, int shortBreakTime, int longBreakTime, int countPeriods){
    pomTimer.updateValues(periodTime, shortBreakTime, longBreakTime, countPeriods);
  }
}

