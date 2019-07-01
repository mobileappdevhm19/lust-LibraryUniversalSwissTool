import 'package:flutter/material.dart';
import 'package:lust/widgets/pomodoroPage/pomodoroDescription.dart';
import 'package:lust/widgets/pomodoroPage/pomodoroTimer.dart';

import 'package:lust/widgets/utils/menuDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

const PeriodTime_KEY = "periodTime";
const ShortBreakTime_KEY = "shortBreakTime";
const LongBreakTime_KEY = "longBreakTime";
const CountPeriods_KEY="countPeriods";



class PomodoroPage extends StatefulWidget {
  static  const String title = "Pomodoro";
  static const IconData icon = Icons.watch;

  @override
  PomodoroState createState() => new PomodoroState();

  String getTitle(){
    return title;
  }
  IconData getIcon(){
    return icon;
  }
}

class PomodoroState extends State<PomodoroPage> {
  String title;
  IconData icon;

  //all in minutes
  int periodTime;
  int shortBreakTime;
  int longBreakTime;
  int countPeriods;

  pomodoroDescription pomDesc;
  PomodoroTimer pomTimer;

  PomodoroState(){
    pomodoroDefaultValues();
    pomDesc=new pomodoroDescription(periodTime, shortBreakTime, longBreakTime, countPeriods, this);
    pomTimer= new PomodoroTimer();
  }

  @override
  void initState() {
    super.initState();
    //updateValues();
    if(widget !=null){
      this.title=widget.getTitle();
      this.icon=widget.getIcon();
    }

    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if(mounted){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      periodTime = prefs.getInt(PeriodTime_KEY);
      shortBreakTime = prefs.getInt(ShortBreakTime_KEY);
      longBreakTime = prefs.getInt(LongBreakTime_KEY);
      countPeriods = prefs.getInt(CountPeriods_KEY);
    }

    if(periodTime ==null || shortBreakTime==null || longBreakTime ==null || countPeriods==null){
      pomodoroDefaultValues();
    }
    pomDesc=new pomodoroDescription(periodTime, shortBreakTime, longBreakTime, countPeriods, this);
    pomTimer= new PomodoroTimer();
    updateVales(periodTime, shortBreakTime, longBreakTime, countPeriods);

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

    //var _height = MediaQuery.of(context).size.height;

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

  void updateVales(int periodTime, int shortBreakTime, int longBreakTime, int countPeriods) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(PeriodTime_KEY, periodTime);
    prefs.setInt(ShortBreakTime_KEY, shortBreakTime);
    prefs.setInt(LongBreakTime_KEY, longBreakTime);
    prefs.setInt(CountPeriods_KEY, countPeriods);

    pomTimer.updateValues(periodTime, shortBreakTime, longBreakTime, countPeriods);
  }

}

