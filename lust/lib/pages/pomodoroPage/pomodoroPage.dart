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
  int periodTime=10;
  int shortBreakTime=4;
  int longBreakTime=3;
  int countPeriods=9;

  pomodoroDescription pomDesc;
  PomodoroTimer pomTimer;


  _PomodoroState(this.title, this.icon){
    pomDesc=new pomodoroDescription(periodTime, shortBreakTime, longBreakTime, countPeriods);
    pomTimer= new PomodoroTimer();
    updateVales(periodTime, shortBreakTime, longBreakTime, countPeriods);
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

