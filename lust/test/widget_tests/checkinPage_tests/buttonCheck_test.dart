import 'package:flutter_test/flutter_test.dart';
import 'package:lust/pages/checkinPage.dart';
import 'package:flutter/material.dart';
import '../../testHelper.dart';


void main() {
  // Define a test. The TestWidgets function will also provide a WidgetTester
  // for us to work with. The WidgetTester will allow us to build and interact
  // with Widgets in the test environment.
  testWidgets('Change text at tap', (WidgetTester tester) async {
    // Create the Widget tell the tester to build it
    // Using the main Widget to get all the needed info for subwidgets
    await tester.pumpWidget(TestHelper.buildWidget(CheckinPage()));

    final buttonFinder = await find.widgetWithText(RawMaterialButton, "Check In!");

    expect(buttonFinder, findsOneWidget);
    //await tester.tap(find.byKey(Key("Checkin")));
  });
}