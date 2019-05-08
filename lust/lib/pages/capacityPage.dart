import 'package:flutter/material.dart';
import 'package:lust/widgets/capacityPage/capacityGraph.dart';
import 'package:lust/widgets/capacityPage/capacityInfo.dart';

class CapacityPage extends StatefulWidget {
  @override
  _CapacityPageState createState() => new _CapacityPageState();
}

class _CapacityPageState extends State<CapacityPage> {
  final _title = "Capacity";

  @override
  Widget build(BuildContext context) {

    var _height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
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
