import 'package:flutter/material.dart';

import 'package:lust/widgets/tutorfinder/tutorOfferings.dart';

import 'package:lust/widgets/utils/menuDrawer.dart';

class TutorFindingPage extends StatelessWidget {
  static String title = "TutorFinder";
  static IconData icon = Icons.help;

  TutorFindingPage();

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery
        .of(context)
        .size
        .height;
    _height -= 85;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(tabs: [
              Tab(text: "Offerings",),
              Tab(text: "Requests",),
            ]),
            title: Text(title),
          ),
          drawer: MenuDrawer.getDrawer(context),
          body: TabBarView(
//              reverse: false,
              children: [ // each children is one tab
                TutorOfferings(),
                Container(
                  child: Text("text"),
                )
              ])),
    );
  } // build
}
