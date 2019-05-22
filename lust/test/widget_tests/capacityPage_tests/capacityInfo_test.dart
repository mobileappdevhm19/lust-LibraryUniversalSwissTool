import 'package:flutter_test/flutter_test.dart';
import 'package:lust/widgets/capacityPage/capacityInfo.dart';
import 'package:flutter/material.dart';
import '../../testHelper.dart';


void main() {
  // Define a test. The TestWidgets function will also provide a WidgetTester
  // for us to work with. The WidgetTester will allow us to build and interact
  // with Widgets in the test environment.
  testWidgets('CapacityInfo has three lines of info and two dividers', (WidgetTester tester) async {
    // Create the Widget tell the tester to build it
    // Using the main Widget to get all the needed info for subwidgets
    await tester.pumpWidget(
        TestHelper.buildWidget(CapacityInfo.withSampleData()));

    // Create our Finders
    final occupancyFinder = find.text("Occupancy current/total:");
    final trendFinder = find.text("Estimated trend:");
    final openingFinder = find.text("Opening hours today:");

    final dividerFinder = find.byType(Divider);

    // Use the `findsOneWidget` matcher provided by flutter_test to verify our
    // Text Widgets appear exactly once in the Widget tree
    expect(occupancyFinder, findsOneWidget);
    expect(trendFinder, findsOneWidget);
    expect(openingFinder, findsOneWidget);

    // Find the dividers (2 in total) between the rows
    expect(dividerFinder, findsNWidgets(2));
  });
}
