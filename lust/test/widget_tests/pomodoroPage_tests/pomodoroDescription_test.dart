import 'package:flutter_test/flutter_test.dart';
import 'package:lust/main.dart';
import 'package:flutter/material.dart';
import '../../testHelper.dart';
import 'package:lust/pages/pomodoroPage.dart';
import 'package:lust/widgets/pomodoroPage/pomodoroDescription.dart';




void main() {
  testWidgets('pomodoroDesc headline tests', (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildWidget(PomodoroPage()));
    checkHeadlines(tester);
  });


  testWidgets('pomodoroDesc TextField', (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildWidget(PomodoroPage()));
    checkTextFieldTexts(tester);
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
  final periodTimeFinder = find.text("time");
  expect(periodTimeFinder, findsOneWidget);

  final periodCountFinder = find.text("count");
  expect(periodCountFinder, findsOneWidget);

  final shortBreakFinder = find.text("short");
  expect(shortBreakFinder, findsOneWidget);

  final longBreakFinder = find.text("long");
  expect(longBreakFinder, findsOneWidget);
}