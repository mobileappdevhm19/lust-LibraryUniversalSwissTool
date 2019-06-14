import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:lust/pages/chatPage.dart';
import 'package:lust/widgets/chatPage/messageTile.dart';
import '../../testHelper.dart';

import 'package:lust/pages/pageContainer.dart';

void main() {
  testWidgets('The chat page has a textfield at the bottom', (WidgetTester tester) async {
    PageContainer page = PageContainer(ChatPage.title, ChatPage.icon, ChatPage('testID', 'topicID'));

    // Create the Widget tell the tester to build it
    await tester.pumpWidget(TestHelper.buildWidget(page.pageObject));

    // Create our Finders
    final titleFinder = find.text('Tutor Chat');
    final textFieldFinder = find.byType(TextField);
    final sendButtonFinder = find.byIcon(Icons.send);
    final hintFinder = find.text('Send a message');

    // Check if the title there
    expect(titleFinder, findsOneWidget);

    // Check if the Textfield is there and has the hint
    expect(textFieldFinder, findsOneWidget);
    expect(hintFinder, findsOneWidget);

    // Check if the send button is there
    expect(sendButtonFinder, findsOneWidget);
  });

  testWidgets('The text entered in the textfield appears as message', (WidgetTester tester) async {
    final String testMessage = 'This is a test message';

    final String randomTopicID = Random(DateTime.now().millisecond).toString();

    PageContainer page = PageContainer(ChatPage.title, ChatPage.icon, ChatPage('testID', randomTopicID));

    // Create the Widget tell the tester to build it
    await tester.pumpWidget(TestHelper.buildWidget(page.pageObject));

    // Create our Finders
    final textFieldFinder = find.byType(TextField);
    final messageTileFinder = find.byType(MessageTile);
    final sendButtonFinder = find.byIcon(Icons.send);
    final hintFinder = find.text('Send a message');
    final messageFinder = find.text(testMessage);

    // Make sure there is no messagetile in the chat
    expect(messageTileFinder, findsNothing);

    expect(hintFinder, findsOneWidget);
    expect(messageFinder, findsNothing);

    // Put the focus on the textField
    await tester.tap(textFieldFinder);
    await tester.pumpAndSettle();

    // Enter a text in the textfield
    await tester.enterText(textFieldFinder, testMessage);
    await tester.pumpAndSettle();

    // Check if the message is in the textfield
    expect(messageFinder, findsOneWidget);

    // Hit the send button to send the message
    await tester.tap(sendButtonFinder);
    await tester.pumpAndSettle(new Duration(seconds: 2));

    // Textfield should be empty
    expect(messageFinder, findsNothing);

    // There should be one message tile now
    //expect(messageTileFinder, findsOneWidget);

  });
}
