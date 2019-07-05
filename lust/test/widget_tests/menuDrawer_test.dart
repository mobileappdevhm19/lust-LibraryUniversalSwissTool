
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import '../testHelper.dart';

import 'package:lust/pages/utils/pageContainer.dart';

import 'package:lust/pages/capacityPage/capacityPage.dart';
import 'package:lust/pages/checkinPage/checkinPage.dart';
import 'package:lust/pages/pomodoroPage/pomodoroPage.dart';

import 'package:lust/widgets/utils/menuDrawer.dart';


void main() {

  /*// Change this number according to the number of pages available in the menu
  int numberOfExpectedTiles = 4;

  testWidgets('Open menu and go to capacitypage.', (WidgetTester tester) async {
    PageContainer page = PageContainer(CapacityPage.title, CapacityPage.icon, CapacityPage());

    // Create the Widget, tell the tester to build it
    await tester.pumpWidget(TestHelper.buildWidget(page.pageObject));

    // Find menu button and open menu
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify there is a tile for the page given by name
    expect(
        find.descendant(of: find.byType(ListView), matching: find.text(page.title)), findsOneWidget);

    // Open the corresponding page
    await tester.tap(find.descendant(of: find.byType(ListView), matching: find.byIcon(page.icon)));
    await tester.pump();

    // Verify the page was opened
    expect(find.byType(page.pageObject.runtimeType), findsOneWidget);
  });

  testWidgets('Open menu and go to checkinpage', (WidgetTester tester) async {
    PageContainer page = PageContainer(CheckinPage.title, CheckinPage.icon, CheckinPage());
    // Create the Widget, tell the tester to build it
    await tester.pumpWidget(TestHelper.buildWidget(page.pageObject));

    // Find menu button and open menu
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // Verify there is a tile for the page given by name
    expect(
        find.descendant(of: find.byType(ListView), matching: find.text(page.title)), findsOneWidget);

    // Open the corresponding page
    await tester.tap(find.descendant(of: find.byType(ListView), matching: find.byIcon(page.icon)));
    await tester.pump();

    // Verify the page was opened
    expect(find.byType(page.pageObject.runtimeType), findsOneWidget);
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
    await tester.pumpWidget(TestHelper.buildWidget(PomodoroPage()));

    // Find menu button and open menu
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    // change the number of expected tiles in the menudrawer
    expect(
        find.descendant(of: find.byType(ListView), matching: find.byType(ListTile)), findsNWidgets(numberOfExpectedTiles));
  });

  testWidgets('Open menu and find accountheader', (WidgetTester tester) async {
    PageContainer page = PageContainer(CapacityPage.title, CapacityPage.icon, CapacityPage());
    // Create the Widget, tell the tester to build it
    await tester.pumpWidget(TestHelper.buildWidget(page.pageObject));

    // Find menu button and open menu
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    expect(find.byType(UserAccountsDrawerHeader), findsOneWidget);

  });*/
}