import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lust/pages/checkinPage/checkinPage.dart';
import 'package:lust/widgets/utils/getTextBox.dart';

import '../../testHelper.dart';

void main(){
  /*String _title, _hint;
  IconData _icon;*/

  testWidgets('Find icons of the TextBoxs', (WidgetTester tester) async {

    //await tester.pumpWidget(TestHelper.buildWidget(TextBox.getTextBox(_title, _hint, _icon)));
    await tester.pumpWidget(TestHelper.buildWidget(CheckinPage()));

    final findIconSubject = await find.byIcon(Icons.local_library);
    final findIconTime = await find.byIcon(Icons.timer);
    final findIconLocker = await find.byIcon(Icons.lock);

    expect(findIconSubject, findsOneWidget);
    expect(findIconTime, findsOneWidget);
    expect(findIconLocker, findsOneWidget);
  });

  testWidgets('Find textBoxs', (WidgetTester tester) async {
    await tester.pumpWidget(TestHelper.buildWidget(CheckinPage()));

    final findTextBox = await find.widgetWithText(TextField, "");

    expect(findTextBox, findsNWidgets(3));
  });

}