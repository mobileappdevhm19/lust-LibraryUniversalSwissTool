import 'package:flutter/material.dart';
import 'package:lust/widgets/pomodoroPage/pomodoroDescription.dart';
import 'package:lust/widgets/pomodoroPage/pomodoroTimer.dart';

import 'package:lust/widgets/utils/menuDrawer.dart';


class PomodoroPage extends StatefulWidget {
  static String title = "Pomodoro";
  static IconData icon = Icons.watch;

  @override
  _PomodoroState createState() => new _PomodoroState(title, icon);
}

class _PomodoroState extends State<PomodoroPage> {
  final String title;
  final icon;

  //all in minutes
  int periodTime;
  int shortBreakTime;
  int longBreakTime;
  int countPeriods;

  _PomodoroState(this.title, this.icon){
    this.periodTime=25;
    this.shortBreakTime=9;
    this.longBreakTime=15;
    this.countPeriods=4;
  }

  @override
  Widget build(BuildContext context) {

    var _height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(title: Text(title)),
        drawer: MenuDrawer.getDrawer(context),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  //height: _height*0.40,
                  child: new pomodoroDescription(periodTime, shortBreakTime, longBreakTime, countPeriods),
                ),
                Expanded(
                  child: new PomodoroTimer(periodTime, shortBreakTime, longBreakTime, countPeriods),
                )
           ]),
        ));
  } // build
}

