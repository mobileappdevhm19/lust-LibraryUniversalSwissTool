import 'package:flutter/material.dart';

import 'package:lust/pages/statefulPage.dart';

import 'package:lust/widgets/capacityPage/capacityGraph.dart';
import 'package:lust/widgets/capacityPage/capacityInfo.dart';

import 'package:lust/widgets/utils/menuDrawer.dart';

class CapacityPage extends StatefulPage {

  CapacityPage({this.title = "Capacity", this.icon = Icons.equalizer});

  final String title;
  final icon;

  @override
  _CapacityPageState createState() => new _CapacityPageState(title, icon);
}

class _CapacityPageState extends State<CapacityPage> {

  _CapacityPageState(this.title, this.icon);

  final String title;
  final icon;

  @override
  Widget build(BuildContext context) {

    var _height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        drawer: MenuDrawer.getDrawer(context),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: _height*0.60,
                  child: CapacityGraph.withSampleData(),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10.0),
                  child: CapacityInfo(),
                )
              ]),
        ));
  } // build

}
