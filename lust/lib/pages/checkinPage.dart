import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lust/widgets/checkinPage/buttonCheck.dart';
import 'package:lust/widgets/utils/getTextBox.dart';

import 'package:lust/widgets/utils/menuDrawer.dart';

class CheckinPage extends StatefulWidget {

  static String title = "Check In/Out";
  static IconData icon = Icons.check_circle_outline;

  @override
  _CheckinPageState createState() => _CheckinPageState(title, icon);
}

class _CheckinPageState extends State<CheckinPage> {

  final String title;
  final icon;

  _CheckinPageState(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        drawer: MenuDrawer.getDrawer(context),
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
