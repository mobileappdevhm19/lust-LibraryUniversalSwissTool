import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lust/widgets/tutorfinder/tutorRequests.dart';
import '../../testHelper.dart';

void main() {
  testWidgets('Login and register buttons', (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildWidget(TutorRequests()));

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
