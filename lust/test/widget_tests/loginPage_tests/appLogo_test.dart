import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lust/pages/loginPage/loginPage.dart';
import '../../testHelper.dart';

void main() {

  testWidgets('app Icon', (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildWidget(LoginPage()));

    final iconFinder = await find.byType(CircleAvatar);

    expect(iconFinder, findsOneWidget);

    await tester.tap(iconFinder);
  });}
