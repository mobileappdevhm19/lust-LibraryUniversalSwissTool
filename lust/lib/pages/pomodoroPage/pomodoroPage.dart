import 'package:flutter/material.dart';
import 'package:lust/widgets/pomodoroPage/pomodoroDescription.dart';
import 'package:lust/widgets/pomodoroPage/pomodoroTimer.dart';

import 'package:lust/widgets/utils/menuDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lust/widgets/utils/getAppBar.dart';
import '../rootPage.dart';
import 'package:lust/pages/utils/authProvider.dart';



const PeriodTime_KEY = "periodTime";
const ShortBreakTime_KEY = "shortBreakTime";
const LongBreakTime_KEY = "longBreakTime";
const CountPeriods_KEY = "countPeriods";


class PomodoroPage extends StatefulWidget {
  static String title = "Pomodoro";
  static IconData icon = Icons.watch;

  PomodoroState pomState;

  PomodoroPage(){
    pomState=new PomodoroState();
    pomState.title=title;
    pomState.icon=icon;
    pomState.initState();
  }

  @override
  PomodoroState createState() => pomState;
}

class PomodoroState extends State<PomodoroPage> {
   String title=""; //default
   IconData icon=Icons.watch; //default

   final double _appBarHeight = 55;

  //all in minutes
  int periodTime;
  int shortBreakTime;
  int longBreakTime;
  int countPeriods;

  pomodoroDescription pomDesc;
  PomodoroTimer pomTimer;

  PomodoroState(){
    pomodoroDefaultValues();
    pomDesc=new pomodoroDescription();
    pomTimer= new PomodoroTimer(this);

  }

  @override
  void initState() {
    super.initState();
    //updateValues();
    if(widget==null) {
      pomodoroDefaultValues();
      return; //only for test
    }
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    periodTime = prefs.getInt(PeriodTime_KEY);
    shortBreakTime=prefs.getInt(ShortBreakTime_KEY);
    longBreakTime= prefs.getInt(LongBreakTime_KEY);
    countPeriods=prefs.getInt(CountPeriods_KEY);

    if(periodTime==null || shortBreakTime ==null || longBreakTime==null || countPeriods==null){
      pomodoroDefaultValues();
    }
    pomDesc.setValues(periodTime, shortBreakTime, longBreakTime, countPeriods, this);
    updateVales(periodTime, shortBreakTime, longBreakTime, countPeriods);

    pomTimer.initPomTimerState();
  }

  //set the default values for pomodoro
  void pomodoroDefaultValues(){
    periodTime=25;
    shortBreakTime=5;
    longBreakTime=15;
    countPeriods=4;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: PreferredSize(child: GetAppBar(title, _signOut), preferredSize: Size.fromHeight(_appBarHeight)),
        resizeToAvoidBottomPadding:false, //important, otherwise overlay, when keyboard
        drawer: MenuDrawer(context),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  child: pomDesc,
                ),
                Expanded(
                  child:pomTimer,
                )
           ]),
        ));
  } // build

  void updateVales(int periodTime, int shortBreakTime, int longBreakTime, int countPeriods)async {
    if(!mounted)return;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt(PeriodTime_KEY, periodTime);
    prefs.setInt(ShortBreakTime_KEY, shortBreakTime);
    prefs.setInt(LongBreakTime_KEY, longBreakTime);
    prefs.setInt(CountPeriods_KEY, countPeriods);


    if(pomTimer != null){
      pomTimer.updateValues(periodTime, shortBreakTime, longBreakTime, countPeriods);
    }
  }

   void _signOut() {
     var auth = AuthProvider.of(context).auth;
     print("CURRENT USER: mateo mateo");
     try {
       auth.signOut();
       MenuDrawer.switchPage(context, RootPage());
     } catch (e) {
       print(e);
     }
   }
}

