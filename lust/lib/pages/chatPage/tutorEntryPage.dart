import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lust/models/tutorEntry.dart';
import 'package:lust/pages/chatPage/chatPage.dart';
import 'package:lust/pages/utils/authProvider.dart';

class TutorEntryPage extends StatefulWidget {
  static String title = "Tutor Entry";
  static IconData icon = Icons.group;

  final TutorEntry tutorEntry;

  TutorEntryPage(this.tutorEntry);

  @override
  _TutorEntryPageState createState() =>
      new _TutorEntryPageState(title, tutorEntry);
}

class _TutorEntryPageState extends State<TutorEntryPage> {
  String title;
  TutorEntry tutorEntry;
  String _userID;



  _TutorEntryPageState(this.title, this.tutorEntry);

  Future<void> setUserID() async {

    var auth = AuthProvider.of(context)?.auth;

    FirebaseUser _firebaseUser = await auth?.getCurrentUser();
    _userID = _firebaseUser?.uid;

  }

  @override
  Widget build(BuildContext context) {
    TextStyle topicStyle = TextStyle(
      fontSize: 30,
    );

    setUserID();

    var _height = MediaQuery.of(context).size.height;
    _height -= 85;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          Container(
            constraints: BoxConstraints.expand(height: 50),
            child: Text(
              tutorEntry.topic,
              textAlign: TextAlign.left,
              style: topicStyle,
              maxLines: 1,
            ),
          ),
          Container(
            constraints: BoxConstraints(
                minHeight: _height - 50 - 65, maxHeight: _height - 50 - 65),
            // TODO magic numbers
            child: SingleChildScrollView(
              child: Text(
                tutorEntry.description,
              ),
            ),
          ),
          RaisedButton(
            child: Text("Chat"),
            onPressed: () => _switchPage(
                context, ChatPage(_userID, tutorEntry.offeringId)),
          )
        ],
      ), //ListView
    );
  } // build

  // method to switch between the pages
  static void _switchPage(BuildContext context, Widget widget) {
    Navigator.push(
        //replace the top view(widget) from the stack with the new one
        context,
        MaterialPageRoute(builder: (BuildContext context) => widget));
  }
}
