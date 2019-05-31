import 'package:flutter_test/flutter_test.dart';
import 'package:lust/main.dart';
import 'package:flutter/material.dart';
import '../../testHelper.dart';
import 'package:lust/pages/pomodoroPage.dart';



void main() {
  // Define a test. The TestWidgets function will also provide a WidgetTester
  // for us to work with. The WidgetTester will allow us to build and interact
  // with Widgets in the test environment.
  testWidgets('pomodoroDescription', (WidgetTester tester) async {
    // Create the Widget tell the tester to build it
    // Using the main Widget to get all the needed info for subwidgets
    await tester.pumpWidget(TestHelper.buildWidget(PomodoroPage()));

    // Create our Finders
    final periodTimeFinder = find.text("period:");
    final breakFinder = find.text("break:");
    final periodsFinder = find.text("periods:");

    final dividerFinder = find.byType(Divider);

    // Use the `findsOneWidget` matcher provided by flutter_test to verify our
    // Text Widgets appear exactly once in the Widget tree
    expect(periodTimeFinder, findsOneWidget);
    expect(breakFinder, findsOneWidget);
    expect(periodsFinder, findsOneWidget);

    // Find the dividers (2 in total) between the rows
    expect(dividerFinder, findsNWidgets(2));
  });
}