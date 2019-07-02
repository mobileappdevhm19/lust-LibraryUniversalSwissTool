import 'package:flutter_test/flutter_test.dart';

import '../../testHelper.dart';

import 'package:lust/widgets/chatPage/messageTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  final String _idFrom = "sender";
  final String _messageContent = "Hello World";
  final String _userID = "receiver";

  MessageTile tile = MessageTile(_idFrom, _messageContent, _userID);

  testWidgets('Test messagetile for sender', (WidgetTester tester) async {

    // Create the Widget tell the tester to build it
    await tester.pumpWidget(TestHelper.buildWidget(tile));

    // Create our Finders
    final senderFinder = find.text(_idFrom);

    // Check if the sender is there
    expect(senderFinder, findsOneWidget);
  });

  testWidgets('Test messagetile for content', (WidgetTester tester) async {

    // Create the Widget tell the tester to build it
    await tester.pumpWidget(TestHelper.buildWidget(tile));

    // Create our Finders
    final contentFinder = find.text(_messageContent);

    // Check if the message content is there
    expect(contentFinder, findsOneWidget);
  });


}
