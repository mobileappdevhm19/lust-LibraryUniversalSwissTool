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

PomodoroState pomPage;

void main() {
  pomPage=new PomodoroState();
  pomDesc=new pomodoroDescription();

  testWidgets('pomodoroDesc headline tests', (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildWidget(PomodoroPage()));
    checkHeadlines(tester);
  });


  testWidgets('pomodoroDesc TextField', (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildWidget(PomodoroPage()));
    checkTextFieldTexts(tester);
  });

  testWidgets('pomodoroDesc checkInitialValues', (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildWidget(PomodoroPage()));
    checkInitialValues(tester);
  });

  testWidgets('pomodoroDesc checkInitialTextFieldsValues', (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildWidget(PomodoroPage()));
    checkInitialTextFieldsValues(tester);
  });

}


void checkHeadlines(WidgetTester tester){
  // Create our Finders
  final periodTimeFinder = find.text("Period");
  final breakFinder = find.text("Break");
  expect(periodTimeFinder, findsOneWidget);
  expect(breakFinder, findsOneWidget);
}

void checkTextFieldTexts(WidgetTester tester){
  final periodTimeFinder = find.text("time [min]");
  expect(periodTimeFinder, findsOneWidget);

  final periodCountFinder = find.text("count");
  expect(periodCountFinder, findsOneWidget);

  final shortBreakFinder = find.text("short [min]");
  expect(shortBreakFinder, findsOneWidget);

  final longBreakFinder = find.text("long [min]");
  expect(longBreakFinder, findsOneWidget);
}

void checkInitialValues(WidgetTester tester){
  pomDesc.setValues(periodTime, shortBreakTime, longBreakTime, countPeriods, pomPage);

  expect(periodTime, pomDesc.periodTime);
  expect(shortBreakTime, pomDesc.shortBreakTime);
  expect(longBreakTime, pomDesc.longBreakTime);
  expect(countPeriods, pomDesc.countPeriods);
  expect(pomPage, pomDesc.pomPage);
}

void checkInitialTextFieldsValues(WidgetTester tester){
  pomDesc.setValuesToTextFields();

  expect(pomDesc.periodTimeController.text, pomDesc.periodTime.toString());
  expect(pomDesc.shortBreakController.text, pomDesc.shortBreakTime.toString());
  expect(pomDesc.longBreakController.text, pomDesc.longBreakTime.toString());
  expect(pomDesc.periodCountController.text, pomDesc.countPeriods.toString());
}
