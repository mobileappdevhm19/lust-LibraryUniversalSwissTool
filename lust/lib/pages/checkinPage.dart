import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lust/widgets/checkinPage/buttonCheck.dart';
import 'package:lust/widgets/utils/getTextBox.dart';

class CheckinPage extends StatefulWidget {
  @override
  _CheckinPageState createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
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
