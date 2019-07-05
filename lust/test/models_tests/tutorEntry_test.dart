import 'package:flutter_test/flutter_test.dart';
import 'package:lust/models/tutorEntry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  test('Create a tutor entry with constructor', () {

    final int mSeconds = 10000000;

    final String documentID = "randomID";
    final String  subject = "subject";
    final String topic = "topic";
    final String description = "This is a description";
    final String userID = "XYZ";
    final Timestamp timeStamp = Timestamp.fromMillisecondsSinceEpoch(mSeconds);

    final entry = TutorEntry(documentID, subject, topic, description, userID, DateTime.fromMillisecondsSinceEpoch(timeStamp.millisecondsSinceEpoch));

    expect(entry.offeringId, documentID);
    expect(entry.description, description);
    expect(entry.topic, topic);
    expect(entry.subject, subject);
    expect(entry.creatorUserID, userID);
    expect(entry.createTime.millisecondsSinceEpoch, timeStamp.millisecondsSinceEpoch);
  });

  test('Create a tutor entry from a map', () {

    final int mSeconds = 10000000;

    final String documentID = "randomID";
    final String  subject = "subject";
    final String topic = "topic";
    final String description = "This is a description";
    final String userID = "XYZ";
    final Timestamp timeStamp = Timestamp.fromMillisecondsSinceEpoch(mSeconds);

    final Map<String, dynamic> map = {
      'subject': subject,
      'topic': topic,
      'description': description,
      'userID': userID,
      'timeStamp': timeStamp
    };

    final entry = TutorEntry.fromMap(map,  documentID);

    expect(entry.offeringId, documentID);
    expect(entry.description, description);
    expect(entry.topic, topic);
    expect(entry.subject, subject);
    expect(entry.creatorUserID, userID);
    expect(entry.createTime.millisecondsSinceEpoch, timeStamp.millisecondsSinceEpoch);
  });
}
