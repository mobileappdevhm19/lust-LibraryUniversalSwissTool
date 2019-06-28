import 'package:flutter_test/flutter_test.dart';
import 'package:lust/main.dart';
import 'package:flutter/material.dart';
import 'package:lust/widgets/pomodoroPage/pomodoroTimer.dart';
import 'dart:io';
import 'dart:async';
import 'package:lust/pages/pomodoroPage.dart';
import 'package:shared_preferences/shared_preferences.dart';



//set member variables
int periodTime=25;
int shortBreakTime=9;
int longBreakTime=15;
int countPeriods=4;
PomodoroTimer pomTimer;//= new PomodoroTimer(periodTime, shortBreakTime, longBreakTime, countPeriods);
PomodoroTimerState pomTimerState;//=new PomodoroTimerState();

int secondRange=1; //range of 1 seconds between timer of class and time at this test class
int actTimeInSeconds=0;
int timerStartTime=0;


const StartTime_KEY = "startTime";

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

  testWidgets('pomodoroTimer Initial Timer', (WidgetTester tester) async {
    await tester.pumpWidget(Lust());
    checkInitalTimerStart(tester);
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

void checkSharedPreferences(WidgetTester tester){
  pomTimerState.initPlatformState();
  int sT=pomTimerState.startTime;

  int difTime=10; //aloowed difTime between startTime and actual Time
  int actTime = new DateTime.now().millisecondsSinceEpoch;
  actTime = (actTime / 1000).toInt();

  expect(((actTime-difTime)<=sT &&sT<=actTime), true);
}

void checkInitalTimerStart(WidgetTester tester) {
  /*pomTimerState.start();
  expect(pomTimerState.isRunning, true);
  findTextInButton("Stop");*/
}




void findTextInButton(String btnText){

  //print("in findTextInButton");
  expect(pomTimerState.startStopBtnText, btnText);

}

void findTextInResetButton(String btnText){

  //print("in findTextInResetButton");
  // Create our Finders
  //final startTextFinder = find.text("reset");
  expect(pomTimerState.resetBtnText, btnText);

}
