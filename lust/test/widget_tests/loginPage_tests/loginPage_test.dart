import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lust/pages/loginPage/loginPage.dart';
import '../../testHelper.dart';

void main() {

  testWidgets('Login and register buttons', (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildWidget(LoginPage()));

    final buttonFinder = await find.widgetWithText(RawMaterialButton, "Log in", skipOffstage: true);
    final buttonFinder2 = await find.widgetWithText(RawMaterialButton, "Register", skipOffstage: true);

    expect(buttonFinder, findsOneWidget);
    expect(buttonFinder2, findsOneWidget);
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