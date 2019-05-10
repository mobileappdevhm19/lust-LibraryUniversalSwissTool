import 'package:flutter_test/flutter_test.dart';
import 'package:lust/main.dart';
import 'package:flutter/material.dart';
import 'package:lust/widgets/pomodoroPage/pomodoroTimer.dart';
import 'dart:io';
import 'dart:async';
import 'package:lust/pages/pomodoroPage.dart';


//set member variables
int periodTime=25;
int shortBreakTime=9;
int longBreakTime=15;
int countPeriods=4;
PomodoroTimerState pomTimer= new PomodoroTimerState(periodTime, shortBreakTime, longBreakTime, countPeriods);

int secondRange=1; //range of 1 seconds between timer of class and time at this test class
int actTimeInSeconds=0;
int timerStartTime=0;


void main() {
  // Define a test. The TestWidgets function will also provide a WidgetTester
  // for us to work with. The WidgetTester will allow us to build and interact
  // with Widgets in the test environment.
  testWidgets('pomodoroTimer Initial Values', (WidgetTester tester) async {
    await tester.pumpWidget(Lust());
    checkInitialValues();
  });
  testWidgets('pomodoroTimer Initial Timer', (WidgetTester tester) async {

//    await tester.tap(find.text('Start'));
    //checkInitalTimerStart();
  });
}

//
void checkInitialValues(){
  findTextInButton("Start");
  findTextInResetButton();
  expect(pomTimer.actStatusText, pomTimer.initialStatusText);
  expect(pomTimer.actTimerSeconds, 0);
}

void checkInitalTimerStart() {
  timerStartTime = new DateTime.now().millisecondsSinceEpoch;
  timerStartTime = (timerStartTime / 1000).toInt();

  print('timerStartTime: $timerStartTime');

  startStopTimer(); //start/ stop the timer();
  sleep(const Duration(seconds:5));
  print('nach sleep');

  //findTextInButton("Stop");
  startStopTimer(); //start/ stop the timer();

  actTimeInSeconds = new DateTime.now().millisecondsSinceEpoch;
  actTimeInSeconds = (actTimeInSeconds / 1000).toInt();

  //now check if PmodoroTimerState::actTimerSeconds is correct (5)
  int timeDif=actTimeInSeconds-timerStartTime;
  print('time Dif: $timeDif');

  int timerSec = getTimerActTimerSeconds();
  if((timeDif-1) < timerSec &&  timerSec> (timeDif+1)){
    timeDif=timerSec;
  }


  print('timer: $timerSec');

  expect(timerSec, timeDif);
}

void startStopTimer() async {
  //await pomTimer.startStopButtonClicked(); //start/ stop the timer();
}



int getTimerActTimerSeconds(){
   return pomTimer.getActTimerSeconds();
}


void findTextInButton(String btnText){

  print("in findTextInButton");
  expect(pomTimer.startStopBtnText, btnText);

}

void findTextInResetButton(){

  print("in findTextInResetButton");
  // Create our Finders
  final startTextFinder = find.text("reset");
  expect(startTextFinder, findsOneWidget);

}