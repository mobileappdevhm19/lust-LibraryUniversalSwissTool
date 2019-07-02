import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lust/models/tutorEntry.dart';
import 'package:lust/pages/chatPage/tutorEntryPage.dart';
import '../../testHelper.dart';

void main() {
  TutorEntry tutorEntry = TutorEntry("offeringID", "subject", "topic",
      "description", "creatorUserID", DateTime.now());

  testWidgets('tutorEntry', (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildWidget(TutorEntryPage(tutorEntry)));

//    final buttonFinder = await find.widgetWithText(RawMaterialButton, "Log in");
//    final buttonFinder2 = await find.widgetWithText(RawMaterialButton, "Register");

//    expect(buttonFinder, findsOneWidget);
//    expect(buttonFinder2, findsOneWidget);
//
//    await tester.tap(buttonFinder);
//    await tester.tap(buttonFinder2);
//    //await tester.tap(find.byKey(Key("Checkin")));
  });
}
