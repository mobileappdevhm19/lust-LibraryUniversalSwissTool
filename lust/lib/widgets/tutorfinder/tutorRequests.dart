import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lust/models/tutorEntry.dart';
import 'package:lust/pages/tutorEntryPage.dart';

class TutorRequests extends StatefulWidget {
  // a constructor for this class
  TutorRequests();

  @override
  State<StatefulWidget> createState() => TutorRequestsState();
}

class TutorRequestsState extends State<TutorRequests> {
  TutorRequestsState();

  List<TutorEntry> offerings = [];
  Firestore db = Firestore.instance;
  StreamSubscription<QuerySnapshot> sub;

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(context) {
    CollectionReference collection = db.collection("tutorRequest");
    Stream<QuerySnapshot> snapshots = collection
        .orderBy("timeStamp", descending: true)
        .where("timeStamp",
            isGreaterThan: DateTime.utc(
                DateTime.now().year, DateTime.now().month, DateTime.now().day))
        .snapshots();

    sub?.cancel();
    sub = snapshots.listen((QuerySnapshot snapshot) {
      final List<TutorEntry> offerings = snapshot.documents
          .map((documentSnapshot) => TutorEntry.fromMap(
              documentSnapshot.data, documentSnapshot.documentID))
          .toList();
      setState(() {
        this.offerings = offerings;
      });
    });

    // Pass the text down to another widget
    return Center(
      child: ListView.builder(
          itemCount: offerings.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, position) {
            return Column(
              children: <Widget>[
                Divider(height: 5.0),
                ListTile(
                  title: Text(
                    '${offerings[position].topic}',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  subtitle: Text(
                    '${offerings[position].description}',
                    style: new TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                    onTap: () =>
                        _switchPage(
                            context, TutorEntryPage(offerings[position]))
                ),
              ],
            );
          }),
    );
  }

  // method to switch between the pages
  static void _switchPage(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
      //replace the top view(widget) from the stack with the new one
        context,
        MaterialPageRoute(builder: (BuildContext context) => widget));
  }
}
