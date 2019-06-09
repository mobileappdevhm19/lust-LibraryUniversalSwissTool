import 'package:flutter/material.dart';
import 'package:lust/utils/autenthicationAPI.dart';
import 'package:lust/models/library.dart';
import 'package:lust/widgets/capacityPage/capacityGraph.dart';
import 'package:lust/widgets/capacityPage/capacityInfo.dart';
import 'package:lust/widgets/utils/menuDrawer.dart';
import 'package:lust/widgets/utils/getAppBar.dart';


class CapacityPage extends StatefulWidget {
  CapacityPage({this.auth});

  static String title = "Capacity";
  static IconData icon = Icons.equalizer;
  BaseAuth auth;

  @override
  _CapacityPageState createState() => new _CapacityPageState(title, icon);
}

class _CapacityPageState extends State<CapacityPage> {
  final String _title;
  final icon;

  _CapacityPageState(this._title, this.icon);

  final Library library = new Library.withSampleData();

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    _height -= 85;
    return Scaffold(
        /*appBar: AppBar(
          title: Text(title),
        ),*/
        appBar: PreferredSize(child: GetAppBar(_title), preferredSize: Size.fromHeight(50)),
        drawer: MenuDrawer.getDrawer(context),
        body: ListView(reverse: false, children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            height: _height * 0.60,
            child: CapacityGraph.fromLibrary(library),
          ),
          Container(
            alignment: Alignment.center,
            height: _height * 0.4,
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: CapacityInfo(library),
          ),
        ]));
  } // build

  _signOut() {
    try {
      widget.auth.signOut();
    } catch (e) {
      print(e);
    }
  }

}
