import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../testHelper.dart';

import 'package:lust/pages/capacityPage.dart';

void main() {

  // Change this number according to the number of pages available in the menu
  int numberOfExpectedTiles = 1;

  testWidgets('Open menu and go to capacitypage.', (WidgetTester tester) async {
    // Create the Widget, tell the tester to build it
    await tester.pumpWidget(TestHelper.buildWidget(CapacityPage()));

    //openPageByType(tester, CapacityPage());
  });

  /*
  Copy this part for your page and fill in the parameters
  Also change the number on top of this function to the number of inserted pages in the menu

  testWidgets('Open menu and go to checkinpage', (WidgetTester tester) async {
    // Create the Widget, tell the tester to build it
    await tester.pumpWidget(TestHelper.buildWidget(YOURPAGECONSTRUCTOR));

    openPageByType(tester, YOURPAGECONSTRUCTOR);
  });
*/

  testWidgets('Open menu and find correct amount of listtiles.', (WidgetTester tester) async {
    // Create the Widget, tell the tester to build it
    await tester.pumpWidget(TestHelper.buildWidget(CapacityPage()));

    // Find menu button and open menu
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pump();

    // change the number of expected tiles in the menudrawer
    expect(
        find.descendant(of: find.byType(ListView), matching: find.byType(ListTile)), findsNWidgets(numberOfExpectedTiles));
  });
}
/*
void openPageByType(tester, StatefulPage page) async {
  // Find menu button and open menu
  await tester.tap(find.byIcon(Icons.menu));
  await tester.pump();
  // Verify there is a tile for the page given by name
  expect(
      find.descendant(of: find.byType(ListView), matching: find.text(page.title)), findsOneWidget);
  // Open the corresponding page
  await tester.tap(find.descendant(of: find.byType(ListView), matching: find.text(page.title)));
  await tester.pump();
  // Verify the page was opened
  expect(find.byType(page.runtimeType), findsOneWidget);
}
*/