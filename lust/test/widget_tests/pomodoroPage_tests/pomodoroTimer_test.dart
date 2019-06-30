import 'package:flutter_test/flutter_test.dart';
import 'package:lust/main.dart';
import 'package:flutter/material.dart';
import 'package:lust/widgets/pomodoroPage/pomodoroTimer.dart';
import 'dart:io';
import 'dart:async';
import 'package:lust/pages/pomodoroPage/pomodoroPage.dart';
import 'package:shared_preferences/shared_preferences.dart';



//set member variables
PomodoroTimer pomTimer;//= new PomodoroTimer(periodTime, shortBreakTime, longBreakTime, countPeriods);
PomodoroTimerState pomTimerState;//=new PomodoroTimerState();

int secondRange=1; //range of 1 seconds between timer of class and time at this test class
int actTimeInSeconds=0;
int timerStartTime=0;


const StartTime_KEY = "startTime";
const IsRunning_KEY = "isRunning";
const ActStatus_KEY="actStatus";

const ActPeriod_KEY="actPeriod";
const OldTimerSeconds_KEY="oldTimerSeconds";


//see https://github.com/flutter/flutter/issues/28837
Future setupSomePreferences(int startTime) async {
  SharedPreferences.setMockInitialValues(<String, dynamic>{'flutter.some.preferences': startTime});
  final preferences = await SharedPreferences.getInstance();
  // TODO this should not be necessary
  // reported issue: https://github.com/flutter/flutter/issues/28837
  await preferences.setInt(StartTime_KEY, startTime);
}


void main() {
  pomTimer= new PomodoroTimer();
  pomTimer.updateValues(1, 1, 1, 1); //default values
  pomTimerState=new PomodoroTimerState();


  setupSomePreferences(null);
  // Define a test. The TestWidgets function will also provide a WidgetTester
  // for us to work with. The WidgetTester will allow us to build and interact
  // with Widgets in the test environment.
  pomTimerState.initState();

  testWidgets('pomodoroTimer Initial Values', (WidgetTester tester) async {
    await tester.pumpWidget(Lust());
    checkInitialValues();
  });

  testWidgets('pomodoroTimer check shared preferences', (WidgetTester tester) async {
    await tester.pumpWidget(Lust());
    checkSharedPreferences(tester);
  });

  testWidgets('pomodoroTimer check shared preferences Status calculation', (WidgetTester tester) async {
    await tester.pumpWidget(Lust());
    checkStatusCalculation(tester);
  });

  testWidgets('pomodoroTimer Initial Timer', (WidgetTester tester) async {
    await tester.pumpWidget(Lust());
    checkInitalTimerStart(tester);
  });

  testWidgets('pomodoroTimer Initial Timer Stop', (WidgetTester tester) async {
    await tester.pumpWidget(Lust());
    checkInitalTimerStop(tester);
  });

  testWidgets('pomodoroTimer Change Status', (WidgetTester tester) async {
    await tester.pumpWidget(Lust());
    checkChangeStatus(tester);
  });

  testWidgets('reset Button', (WidgetTester tester) async {
    await tester.pumpWidget(Lust());
    resetButton(tester);
  });
}

//
void checkInitialValues(){
  findTextInButton("Start");
  findTextInResetButton("reset");

  expect( pomTimerState.actTimerSeconds, 0);
  expect( pomTimerState.actTimeMinutesSeconds,"00 : 00");
  expect(pomTimerState.actStatusText, pomTimerState.initialStatusText);
  expect(pomTimerState.isRunning, false);
}

void checkSharedPreferences(WidgetTester tester) async{
  int actTime = new DateTime.now().millisecondsSinceEpoch;
  actTime = (actTime / 1000).toInt();

  pomTimerState.initPlatformState();
  int sT=pomTimerState.startTime;

  int difTime=2; //aloowed difTime between startTime and actual Time

  expect(((actTime-difTime)<=sT &&sT<=actTime), true);

  print("now check SharedPreferences when restart");
  const int waitSec=5000;
  sleep(const Duration(milliseconds: waitSec));
  pomTimerState.initPlatformState();
  sT=pomTimerState.startTime;
  int oldTime=actTime;
  actTime = new DateTime.now().millisecondsSinceEpoch;
  actTime = (actTime / 1000).toInt();

  expect(((actTime-difTime)<=sT &&sT<=actTime), false);
  expect(((oldTime-difTime)<=sT &&sT<=oldTime), true);

  //to set variables
  pomTimerState.changeStatus();
  pomTimerState.start();

  pomTimerState.initPlatformState();
  SharedPreferences prefs = await SharedPreferences.getInstance();


  expect(((oldTime-difTime)<=sT &&sT<=oldTime), true);
  //prefs.setInt(ActStatus_KEY, 0);

}

//call initPlatfom state with different times to go through the whole loop where the act status calculating
void checkStatusCalculation(WidgetTester tester) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  int actTime, startTime;
  int dif=5; //always adding 5 sec to time (because the time runs, and maybe it wuld be the next case)

  prefs.setInt(ActStatus_KEY, 0);
  pomTimerState.start();

  pomTimerState.initPlatformState();
  prefs.setBool(IsRunning_KEY, true); //important, otherwise never go in the loop
  prefs.setInt(ActStatus_KEY, 0);//nothing
  prefs.setInt(OldTimerSeconds_KEY,0);
  prefs.setInt(ActPeriod_KEY, 0);

  String aS;

  actTime = new DateTime.now().millisecondsSinceEpoch;
  actTime = (actTime / 1000).toInt();

  aS=pomTimerState.actStatus.toString();
  print("$aS");

  for(int i=1; i<pomTimerState.countPeriods; i++) {
    pomTimerState.changeStatus();
    pomTimerState.initPlatformState();

    aS = pomTimerState.actStatus.toString();
    print("$aS");

    pomTimerState.changeStatus();
    pomTimerState.initPlatformState();

    aS = pomTimerState.actStatus.toString();
    print("$aS");
  }
  pomTimerState.changeStatus();
  pomTimerState.initPlatformState();

  pomTimerState.changeStatus();
  pomTimerState.initPlatformState();

  expect(pomTimerState.actStatus, Status.longBreak);


  /*SharedPreferences prefs = await SharedPreferences.getInstance();
  int actTime, startTime;
  int dif=5; //always adding 5 sec to time (because the time runs, and maybe it wuld be the next case)

  pomTimerState.changeStatus();
  pomTimerState.start();

  pomTimerState.initPlatformState();
  prefs.setBool(IsRunning_KEY, true); //important, otherwise never go in the loop
  prefs.setInt(ActStatus_KEY, 0);//nothing
  prefs.setInt(OldTimerSeconds_KEY,0);
  prefs.setInt(ActPeriod_KEY, 0);

  String aS;

  actTime = new DateTime.now().millisecondsSinceEpoch;
  actTime = (actTime / 1000).toInt();
  startTime=actTime;//

  //paheses always -1, 25, 9, 15 (default for tests)

  for(int i=0; i<pomTimerState.countPeriods; i++){
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    startTime = startTime-pomTimerState.statuslist[1].time+5;
    prefs.setInt(StartTime_KEY, startTime);//nothing
    int difTime=pomTimerState.statuslist[1].time;
    int difAct=actTime-startTime;
    print("def Time $difTime    difAct $difAct");
    pomTimerState.initPlatformState();
    aS=pomTimerState.actStatus.toString();
    print("$aS");

/*
    //short break
    startTime = startTime-pomTimerState.statuslist[2].time;
    prefs.setInt(StartTime_KEY, startTime);//nothing
    difTime=pomTimerState.statuslist[2].time;
    difAct=actTime-startTime;
    print("def Time $difTime    difAct $difAct");

    pomTimerState.initPlatformState();
    aS=pomTimerState.actStatus.toString();
    print("$aS"); */
  }

  //now check long break
*/

}



void checkInitalTimerStart(WidgetTester tester) {
  pomTimerState.start();
  findTextInButton("Stop");
  expect(pomTimerState.isRunning, true);
}

void checkInitalTimerStop(WidgetTester tester) {
  pomTimerState.stop();
  findTextInButton("Start");
  expect(pomTimerState.isRunning, false);
}

void checkChangeStatus(WidgetTester tester) {
  for(int i=1; i<pomTimerState.countPeriods;i++){
    pomTimerState.changeStatus();
    String aS=pomTimerState.actStatus.toString();
    print("$aS");
    expect(pomTimerState.actStatus, Status.learning);
    pomTimerState.changeStatus();
    aS=pomTimerState.actStatus.toString();
    print("$aS");
    expect(pomTimerState.actStatus, Status.shortBreak);
  }
  pomTimerState.changeStatus(); //learining
  String aS=pomTimerState.actStatus.toString();
  print("$aS");
  pomTimerState.changeStatus();
  aS=pomTimerState.actStatus.toString();
  print("$aS");
  expect(pomTimerState.actStatus, Status.longBreak);
}

void findTextInButton(String btnText){
  expect(pomTimerState.startStopBtnText, btnText);
}

void findTextInResetButton(String btnText){
  expect(pomTimerState.resetBtnText, btnText);
}


void resetButton(WidgetTester tester) {
  pomTimerState.changeStatus(); //just that status is not nothing

  int tSec=10;
  pomTimerState.actTimerSeconds=tSec;

  AlertDialog resDiag=pomTimerState.resetAlertDiaglog();
  expect(resDiag.actions.length, 2);

  FlatButton closeBtn=resDiag.actions[0];
  closeBtn.onPressed();
  expect( pomTimerState.actStatus, Status.learning);
  expect( pomTimerState.actTimerSeconds, tSec);

  FlatButton resetBtn=resDiag.actions[1];
  resetBtn.onPressed();
  expect( pomTimerState.actStatus, Status.nothing);
  expect( pomTimerState.actTimerSeconds, 0);

}