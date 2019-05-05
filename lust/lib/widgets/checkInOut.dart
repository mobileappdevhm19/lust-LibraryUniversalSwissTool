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
            Text("manuel"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Subject",
                  style: TextStyle(),
                ),
                TextField(
                  onChanged:(value){},
                  style: TextStyle(color: Colors.red),
                  decoration: InputDecoration(),

                )
              ],
            )
            //TextBox.getTextBox(context, "Subject"),
            //TextBox.getTextBox(context, "Time goal"),
            //TextBox.getTextBox(context, "Locker number"),
          ],
        )));
  }
}
