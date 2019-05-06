import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
<<<<<<< HEAD
import 'package:lust/widgets/widgetCreator.dart';
=======
// import 'package:lust/widgets/widgetCreator.dart'; // commented out because of revert #71
>>>>>>> a3c481a07447757cd5482eb46ba3e064dd895a1f
import 'package:lust/widgets/getTextBox.dart';

class CheckInOut extends StatefulWidget {
  @override
  _CheckInOutState createState() => _CheckInOutState();
}

class _CheckInOutState extends State<CheckInOut> {
  final String _title = "Check In/Out";
  String _example; //PROVISIONAL

  String _textButton = "Check In!";
  MaterialColor _colorButton = Colors.green; //change once pressed the button
  bool _buttonState = false;

  @override
  Widget build(BuildContext context) {
    print("INICIO + $_textButton");
    return Scaffold(
        appBar: AppBar(title: Text(_title)),
<<<<<<< HEAD
        drawer: WidgetCreator.getDrawer(context),
=======
        //drawer: WidgetCreator.getDrawer(context), // commented out because of revert PR #71
>>>>>>> a3c481a07447757cd5482eb46ba3e064dd895a1f
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextBox.getTextBox(context, "Subject", "Good luck with that!"),
            TextBox.getTextBox(context, "Time goal", "Be realistic!"),
            TextBox.getTextBox(context, "Locker number",
               "I know that is difficult to remember"),
            InkWell(
                onTap: onButtonPressed,
                child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        color: _colorButton),
                    child: Center(
                        child: Text(
                      _textButton,
                      style: TextStyle(fontSize: 28),
                    ))))
          ],
        )));
  }

  void onButtonPressed() {
    setState(() {
      print("HOP");

      if (_buttonState == true) {
        _buttonState = false;
        _colorButton = Colors.green;
        _textButton = "Check In!";
      } else {
        _buttonState = true;
        _colorButton = Colors.red;
        _textButton = "Check out";
      }
    });
  }
}
