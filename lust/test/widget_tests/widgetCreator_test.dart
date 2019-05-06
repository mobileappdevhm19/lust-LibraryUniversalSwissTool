import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lust/main.dart';

void main() {
  testWidgets('Menu opens and lets you navigate through the app',
      (WidgetTester tester) async {
    // Create the Widget tell the tester to build it
    await tester.pumpWidget(Lust());

    final menuFinder = null;

    expect(menuFinder, null);

    openMenu(tester);

    // Verify that the menu opened
    // TODO: verify the menu and every list tile in it
    // TODO: make it fail if there are more tiles in it

    // Verify that the correct page opens after pressing a tile
    // TODO: tap each tile in the menu and verify the correct page
  });
}

void openMenu(tester) async {
  await tester.tap(find.byIcon(Icons.menu));
  await tester.pump();
}
