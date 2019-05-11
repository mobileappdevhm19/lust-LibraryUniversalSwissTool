import 'package:flutter/material.dart';

import 'package:lust/pages/statefulPage.dart';

import 'package:lust/widgets/capacityPage/capacityGraph.dart';
import 'package:lust/widgets/capacityPage/capacityInfo.dart';

import 'package:lust/widgets/utils/menuDrawer.dart';

class CapacityPage extends StatefulPage {

  CapacityPage({String title = "Capacity", icon = Icons.equalizer}) : super(title, icon);

  @override
  _CapacityPageState createState() => new _CapacityPageState(title, icon);
}

class _CapacityPageState extends State<CapacityPage> {

  final String title;
  final icon;

  _CapacityPageState(this.title, this.icon);

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
