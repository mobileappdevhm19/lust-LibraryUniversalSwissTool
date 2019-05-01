import 'package:flutter/material.dart';

class CapacityWidget extends StatefulWidget {
  @override
  _CapacityWidgetState createState() => new _CapacityWidgetState();
}

class _CapacityWidgetState   extends State<CapacityWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Capacity'),
        ),
        body: Center(
          child: Text('The Capacity here'),
        ));
  } // build
}
