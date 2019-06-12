/// A class to represent one tutor offering

class TutorEntry {
  String offeringId;
  String description;
  String topic;
  String subject;
  String creatorUserID;
  DateTime createTime;

  TutorEntry(this.offeringId, this.subject, this.topic, this.description,
      this.creatorUserID, this.createTime);

  TutorEntry.fromMap(Map<String, dynamic> map, String documentID)
      : this(
            documentID,
            map['subject'],
            map['topic'],
            map['description'],
            map['userID'],
            DateTime.fromMillisecondsSinceEpoch(
                map['timeStamp'].seconds * 1000));
}
