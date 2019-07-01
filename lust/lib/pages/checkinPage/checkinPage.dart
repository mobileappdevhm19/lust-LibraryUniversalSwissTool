import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lust/pages/loginPage/loginPage.dart';
import 'package:lust/pages/rootPage.dart';
import 'package:lust/utils/autenthicationAPI.dart';
import 'package:lust/widgets/checkinPage/buttonCheck.dart';
import 'package:lust/widgets/utils/getAppBar.dart';
import 'package:lust/widgets/utils/getTextBox.dart';

import 'package:lust/widgets/utils/menuDrawer.dart';

class CheckinPage extends StatefulWidget {
  CheckinPage({this.auth, this.onSignedOut});
  VoidCallback onSignedOut;

  static String title = "Check In/Out";
  static IconData icon = Icons.check_circle_outline;
  final BaseAuth auth;

  @override
  _CheckinPageState createState() => _CheckinPageState(title, icon);
}

class _CheckinPageState extends State<CheckinPage> {
  final String title;
  final icon;
  final GlobalKey<ScaffoldState> _scaffState = new GlobalKey<ScaffoldState>();

  _CheckinPageState(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery
        .of(context)
        .size
        .height;
    _height -= 85;

    return Scaffold(
        key: _scaffState,
        appBar: PreferredSize(child: GetAppBar(title, _signOut),
            preferredSize: Size.fromHeight(55)),
        drawer: MenuDrawer.getDrawer(context),
        body: ListView(children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            height: _height * 0.4,
            child: Column(
              children: <Widget>[
                TextBox.getTextBox(context, "Subject", "Good luck with that!",
                    Icons.local_library),
                TextBox.getTextBox(
                    context, "Time goal", "Be realistic!", Icons.timer),
                TextBox.getTextBox(context, "Locker number",
                    "I know that is difficult to remember", Icons.lock),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: _height * 0.6,
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: ButtonCheck(scaffState: _scaffState),
          ),
        ]));
  }

  void _signOut() {
    print("CURRENT USER: mateo mateo");
    try {
      widget.auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
