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

  testWidgets('Make login proceedure', (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildWidget(LoginPage()));

    final String testEmail = "test@whatever.com";
    final String testPword = "dsaeiu";

    final emailTextFinder = find.text(testEmail);
    final pwordTextFinder = find.text(testPword);

    final emailBoxFinder = await find.widgetWithText(TextFormField, "Email");
    final passwordBoxFinder = await find.widgetWithText(TextFormField, "LUST - LibUniversalSwissTool");

    final loginButtonFinder = await find.widgetWithText(RawMaterialButton, "Log in");
    final registerButtonFinder = await find.widgetWithText(RawMaterialButton, "Register");

    expect(emailBoxFinder, findsOneWidget);
    expect(passwordBoxFinder, findsOneWidget);

    // Put the focus on the emailfield
    await tester.tap(emailBoxFinder);
    await tester.pumpAndSettle();

    // Enter a text in the emailfield
    await tester.enterText(emailBoxFinder, testEmail);
    await tester.pumpAndSettle();

    // Put the focus on the passwordfield
    await tester.tap(passwordBoxFinder);
    await tester.pumpAndSettle();

    // Enter a text in the paswordfield
    await tester.enterText(passwordBoxFinder, testPword);
    await tester.pumpAndSettle();

    // Check if values are in the textfields
    expect(emailTextFinder, findsOneWidget);
    expect(pwordTextFinder, findsOneWidget);

    //await tester.tap(registerButtonFinder);
    //await tester.pumpAndSettle();

    //await tester.tap(loginButtonFinder);
    //await tester.pumpAndSettle();
  });


  testWidgets('Make login proceedure without entries', (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildWidget(LoginPage()));

    final loginButtonFinder = await find.widgetWithText(RawMaterialButton, "Log in");
    final registerButtonFinder = await find.widgetWithText(RawMaterialButton, "Register");

    final emailErrorMessageFinder = await find.text("Please write your email");
    final pwordErrorMessageFinder = await find.text("You have to write something!");

    expect(loginButtonFinder, findsOneWidget);
    expect(registerButtonFinder, findsOneWidget);

    // Put the focus on the textField
    await tester.tap(loginButtonFinder);
    await tester.pumpAndSettle();

    // Check if the error message appears
    expect(emailErrorMessageFinder, findsOneWidget);
    expect(pwordErrorMessageFinder, findsOneWidget);

    // Find snackbar
  });

  testWidgets('Make register proceedure without entries', (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildWidget(LoginPage()));

    final loginButtonFinder = await find.widgetWithText(RawMaterialButton, "Log in");
    final registerButtonFinder = await find.widgetWithText(RawMaterialButton, "Register");

    final emailErrorMessageFinder = await find.text("Please write your email");
    final pwordErrorMessageFinder = await find.text("You have to write something!");

    expect(loginButtonFinder, findsOneWidget);
    expect(registerButtonFinder, findsOneWidget);

    // Put the focus on the textField
    await tester.tap(registerButtonFinder);
    await tester.pumpAndSettle();

    // Check if the error message appears
    expect(emailErrorMessageFinder, findsOneWidget);
    expect(pwordErrorMessageFinder, findsOneWidget);

    // Find Snackbar
  });
}