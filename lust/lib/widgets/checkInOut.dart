import 'package:flutter/material.dart';
import 'widgetCreator.dart';
import 'getTextBox.dart';

class CheckInOut extends StatefulWidget {
  @override
  _CheckInOutState createState() => _CheckInOutState();
}

class _CheckInOutState extends State<CheckInOut> {
  final String _title = "Check In/Out";

  String _textButton;
  MaterialColor _colorButton = Colors.green; //change once pressed the button
  bool _buttonState = false;

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
                TextBox.getTextBox(context, "Locker number",
                    "I know that is difficult to remember"),
                Container(
                    width: 200,
                    height: 200,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle, color: _colorButton),
                    child: InkWell(
                      onTap: onButtonPressed,      //changes color and text!
                    ),
                )
              ],
            )));
  }

  void onButtonPressed(){
    if (_buttonState){
      _buttonState=false;
      _colorButton = Colors.green;
      _textButton = "Check In!";
    }
    else{
      _buttonState=true;
      _colorButton = Colors.red;
      _textButton="Check out :(";
    }
  }
}
