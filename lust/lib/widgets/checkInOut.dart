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
        body: Column(
          children: <Widget>[
            Text("manuel"),
            TextBox.getTextBox(context, "Subject"),
            TextBox.getTextBox(context, "Time goal"),
            TextBox.getTextBox(context, "Locker number"),
          ],
        ));
  }
}

