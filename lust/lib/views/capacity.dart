import 'package:flutter/material.dart';
import 'package:lust/widgets/capacityGraph.dart';
import 'package:lust/widgets/capacityInfo.dart';

class CapacityWidget extends StatefulWidget {
  @override
  _CapacityWidgetState createState() => new _CapacityWidgetState();
}

class _CapacityWidgetState extends State<CapacityWidget> {
  final _title = "Capacity";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CapacityGraph.withSampleData(),
                ),
                CapacityInfo(),
              ]),
        ));
  } // build

}
