import 'package:flutter/material.dart';

class pomodoroTimer extends StatelessWidget {
  int periodTime;
  int shortBreakTime;
  int longBreakTime;
  int countPeriods;

  pomodoroTimer(int periodTime, int shortBreakTime, int longBreakTime, int countPeriods) {
    this.periodTime = periodTime;
    this.shortBreakTime = shortBreakTime;
    this.longBreakTime = longBreakTime;
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
                onPressed: () {},
                child: const Text(
                    'Enabled Button',
                    style: TextStyle(fontSize: 20)
                ),
              ),
            ],
         ),
        ),
    );
  }




}