import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lust/pages/loginPage.dart';
import '../../testHelper.dart';

void main() {

  testWidgets('Login and register buttons', (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildWidget(LoginPage()));

    final buttonFinder = await find.widgetWithText(RawMaterialButton, "Log in");
    final buttonFinder2 = await find.widgetWithText(RawMaterialButton, "Register");

    expect(buttonFinder, findsOneWidget);
    expect(buttonFinder2, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.tap(buttonFinder2);
    //await tester.tap(find.byKey(Key("Checkin")));
  });

  testWidgets('Find icons of the TextBoxs', (WidgetTester tester) async {

    //await tester.pumpWidget(TestHelper.buildWidget(TextBox.getTextBox(_title, _hint, _icon)));
    await tester.pumpWidget(TestHelper.buildWidget(LoginPage()));

    final findIconEmail = await find.byIcon(Icons.email);
    final findIconPassword = await find.byIcon(Icons.security);

    expect(findIconEmail, findsOneWidget);
    expect(findIconPassword, findsOneWidget);
  });

  testWidgets('Find textBoxs', (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildWidget(LoginPage()));

    final findTextBox = await find.widgetWithText(TextFormField, "");

    expect(findTextBox, findsNWidgets(2));
  });
}