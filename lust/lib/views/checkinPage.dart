import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lust/widgets/buttonCheck.dart';
import 'package:lust/widgets/widgetCreator.dart';
import 'package:lust/widgets/getTextBox.dart';

class CheckInOut extends StatefulWidget {
  @override
  _CheckInOutState createState() => _CheckInOutState();
}

class _CheckInOutState extends State<CheckInOut> {
  final String _title = "Check In/Out";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_title)),
        body: Center(
            child: Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextBox.getTextBox(context, "Subject",
                        "Good luck with that!", Icons.local_library),
                    TextBox.getTextBox(
                        context, "Time goal", "Be realistic!", Icons.timer),
                    TextBox.getTextBox(context, "Locker number",
                        "I know that is difficult to remember", Icons.lock),
                    ButtonCheck(),
                    ]))));
  }

}
