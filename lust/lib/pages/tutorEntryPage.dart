import 'package:flutter/material.dart';
import 'package:lust/widgets/utils/menuDrawer.dart';
import 'package:lust/models/tutorEntry.dart';
import 'package:lust/widgets/utils/oneLineText.dart';
import 'package:lust/pages/chatPage.dart';

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

  _TutorEntryPageState(this.title, this.tutorEntry);

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery
        .of(context)
        .size
        .height;
    _height -= 85;
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        drawer: MenuDrawer.getDrawer(context),
        body: ListView(
          children: <Widget>[
            OneLineText(text: "Topic:", fontSize: 22.0,),
            OneLineText(text: tutorEntry.topic),
            OneLineText(text: "Description:", fontSize: 22.0,),
            OneLineText(text: tutorEntry.description),
            RaisedButton(
              child: Text("Chat"),
              onPressed: () => _switchPage(context, ChatPage("testUser", tutorEntry.offeringId)),
            )


          ],

        ));
  } // build

  // method to switch between the pages
  static void _switchPage(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
      //replace the top view(widget) from the stack with the new one
        context,
        MaterialPageRoute(builder: (BuildContext context) => widget));
  }

}
