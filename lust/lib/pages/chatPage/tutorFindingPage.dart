import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lust/pages/utils/authProvider.dart';

import 'package:lust/widgets/tutorfinder/tutorOfferings.dart';
import 'package:lust/widgets/tutorfinder/tutorRequests.dart';
import 'package:lust/pages/chatPage/addTutorEntryPage.dart';

import 'package:lust/widgets/utils/menuDrawer.dart';
import 'package:path/path.dart';

import '../rootPage.dart';

class TutorFindingPage extends StatelessWidget {
  static String title = "TutorFinder";
  static IconData icon = Icons.help;

  TutorFindingPage();

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    _height -= 85;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.power_settings_new),
                  onPressed: () => _signOut(context))
            ],
            bottom: TabBar(tabs: [
              Tab(
                text: "Offerings",
              ),
              Tab(
                text: "Requests",
              ),
            ]),
            title: Text(title),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _switchPage(context, AddTutorEntryPage()),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          //drawer: MenuDrawer.getDrawer(context),
          drawer: MenuDrawer(),
          body: TabBarView(
//              reverse: false,
              children: [
                // each children is one tab
                TutorOfferings(),
                TutorRequests(),
              ])),
    );
  } // buildx

  // method to switch between the pages
  static void _switchPage(BuildContext context, Widget widget) {
    Navigator.push(
        //replace the top view(widget) from the stack with the new one
        context,
        MaterialPageRoute(builder: (BuildContext context) => widget));
  }

  void _signOut(BuildContext context) {
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
