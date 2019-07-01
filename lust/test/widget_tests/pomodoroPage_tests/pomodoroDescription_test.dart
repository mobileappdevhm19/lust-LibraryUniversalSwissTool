import 'package:flutter_test/flutter_test.dart';
import 'package:lust/main.dart';
import 'package:flutter/material.dart';
import '../../testHelper.dart';
import 'package:lust/pages/pomodoroPage.dart';
import 'package:lust/widgets/pomodoroPage/pomodoroDescription.dart';

pomodoroDescription pomDesc;

int periodTime=10;
int shortBreakTime=4;
int longBreakTime=3;
int countPeriods=9;



void main() {

  pomDesc=new pomodoroDescription(periodTime, shortBreakTime, longBreakTime, countPeriods, null);

  testWidgets('pomodoroDesc headline tests', (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildWidget(Lust()));
    checkHeadlines(tester);
  });


  testWidgets('pomodoroDesc TextField', (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildWidget(Lust()));
    checkTextFieldTexts(tester);
  });
}


void checkHeadlines(WidgetTester tester){
  // Create our Finders
  expect(pomDesc.periodString, "period");
  expect(pomDesc.breakString, "break");
}

void checkTextFieldTexts(WidgetTester tester){
  expect(pomDesc.periodTimeString, "time [min]");
  expect(pomDesc.periodCountString, "count");
  expect(pomDesc.shortBreakString, "short [min]");
  expect(pomDesc.longBreakString, "long [min]");
}
