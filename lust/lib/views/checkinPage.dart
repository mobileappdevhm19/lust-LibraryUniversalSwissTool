import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lust/widgets/widgetCreator.dart';
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
  MaterialColor _splashButton = Colors.red;
  bool _buttonState = false;

  @override
  Widget build(BuildContext context) {
    print("INICIO + $_textButton");
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
                    Padding(
                        padding: EdgeInsets.only(top: 60),
                        child:
                            /*MaterialButton(
                          height: 50,
                          onPressed: onButtonPressed,
                          child: Text(
                            _textButton,
                            //style: TextStyle(fontSize: 28),
                          ),
                          padding: EdgeInsets.all(20),
                          color: _colorButton,
                          splashColor: _splashButton,
                          elevation: 5,
                          shape: CircleBorder(
                              side: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.black26,
                                  width: 10)),
                        )*/

                            InkWell(
                                onTap: onButtonPressed,
                                child: Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(150),
                                        color: _colorButton),
                                    child: Center(
                                        child: Text(
                                      _textButton,
                                      style: TextStyle(fontSize: 28),
                                    )))))
                  ],
                ))));
  }

  void onButtonPressed() {
    setState(() {
      print("HOP");

      if (_buttonState == true) {
        _buttonState = false;
        _colorButton = Colors.green;
        _splashButton = Colors.red;
        _textButton = "Check In!";
      } else {
        _buttonState = true;
        _colorButton = Colors.red;
        _splashButton = Colors.green;
        _textButton = "Check out";
      }
    });
  }
}
