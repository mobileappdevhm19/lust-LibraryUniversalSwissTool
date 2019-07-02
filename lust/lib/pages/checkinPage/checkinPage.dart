import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lust/pages/utils/authProvider.dart';
import 'package:lust/widgets/checkinPage/buttonCheck.dart';
import 'package:lust/widgets/utils/getAppBar.dart';
import 'package:lust/widgets/utils/getTextBox.dart';

import 'package:lust/widgets/utils/menuDrawer.dart';

import '../rootPage.dart';

class CheckinPage extends StatefulWidget {
  CheckinPage({this.onSignedOut});
  VoidCallback onSignedOut;

  static String title = "Check In/Out";
  static IconData icon = Icons.check_circle_outline;

  @override
  _CheckinPageState createState() => _CheckinPageState(title, icon);
}

class _CheckinPageState extends State<CheckinPage> {
  final String title;
  final icon;
  final GlobalKey<ScaffoldState> _scaffState = new GlobalKey<ScaffoldState>();

  final double _appBarHeight = 55;

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
            preferredSize: Size.fromHeight(_appBarHeight)),
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
    var auth = AuthProvider.of(context).auth;
    print("CURRENT USER: mateo mateo");
    try {
      auth.signOut();
      MenuDrawer.switchPage(context, RootPage());
    } catch (e) {
      print(e);
    }
  }
}
