import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lust/main.dart';

import 'package:lust/views/capacityPage.dart';

void main() {
  testWidgets('Menu opens and lets you navigate through the app',
      (WidgetTester tester) async {
    // Create the Widget tell the tester to build it
    await tester.pumpWidget(Lust());

    await openPageByName(tester, "Capacity");



    // Verify that the correct page opens after pressing a tile
    // TODO: tap each tile in the menu and verify the correct page
  });
}
/*
void openMenu(tester) async {
  await tester.tap(find.byIcon(Icons.menu));
  await tester.pump();
}
*/

void openPageByName(tester, String name) async {
  // Find menu button and open menu
  await tester.tap(find.byIcon(Icons.menu));
  await tester.pump();
  // Verify there is a tile for the page given by name
  expect(find.descendant(of: find.byType(ListView), matching: find.text(name)), findsOneWidget);
  // Open the corresponding page
  await tester.tap(find.descendant(of: find.byType(ListView), matching: find.text(name)));
  await tester.pump();
  // Verify the page was opened
  expect(find.byType(CapacityPage), findsOneWidget);
}