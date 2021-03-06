import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lust/pages/loginPage/loginPage.dart';
import 'package:lust/pages/utils/authProvider.dart';
import 'package:lust/models/library.dart';
import 'package:lust/utils/autenthicationAPI.dart';
import 'package:lust/widgets/capacityPage/capacityGraph.dart';
import 'package:lust/widgets/capacityPage/capacityInfo.dart';
import 'package:lust/widgets/utils/getAppBar.dart';
import 'package:lust/widgets/utils/menuDrawer.dart';

import '../rootPage.dart';

class CapacityPage extends StatefulWidget {
  CapacityPage({this.onSignedOut});

  VoidCallback onSignedOut;

  static String title = "Capacity";
  static IconData icon = Icons.equalizer;

  @override
  _CapacityPageState createState() => new _CapacityPageState(title, icon);
}

class _CapacityPageState extends State<CapacityPage> {
  final String title;
  final icon;

  _CapacityPageState(this.title, this.icon);

  final double _appBarHeight = 55;

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    _height -= 85;
    return Scaffold(
        /*appBar: AppBar(
          title: Text(title),
        ),*/
        appBar: PreferredSize(
            child: GetAppBar(title, _signOut),
            preferredSize: Size.fromHeight(_appBarHeight)),
        drawer: MenuDrawer(context),
        body: ListView(reverse: false, children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            height: _height * 0.60,
            child: CapacityGraph(),
          ),
          Container(
            alignment: Alignment.center,
            height: _height * 0.4,
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: CapacityInfo(),
          ),
        ]));
  } // build

  void _signOut() async {
    try {
      var auth = AuthProvider.of(context).auth;
      FirebaseUser _userID = await auth.getCurrentUser();
      print("USER: $_userID.uid");

      auth.signOut();
      MenuDrawer.switchPage(context, RootPage());
      //widget.onSignedOut();       //callback
    } catch (e) {
      print(e);
    }
  }
}
