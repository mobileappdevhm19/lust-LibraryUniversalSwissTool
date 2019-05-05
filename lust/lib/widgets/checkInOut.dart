import 'package:flutter/material.dart';
import 'widgetCreator.dart';
import 'getTextBox.dart';

class CheckInOut extends StatefulWidget {
  @override
  _CheckInOutState createState() => _CheckInOutState();
}

class _CheckInOutState extends State<CheckInOut> {
  final _title = "Check In/Out";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_title)),
        drawer: WidgetCreator.getDrawer(context),
        body: Container(
          padding: EdgeInsets.all(10),
            child: Column(
          children: <Widget>[
            TextBox.getTextBox(context, "Subject", "Good luck with that!"),
            TextBox.getTextBox(context, "Time goal", "Be realistic!"),
            TextBox.getTextBox(context, "Locker number","I know that is difficult to remember"),
          ],
        )));
  }
}
