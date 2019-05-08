import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonCheck extends StatefulWidget {
  @override
  _ButtonCheckState createState() => _ButtonCheckState();
}

class _ButtonCheckState extends State<ButtonCheck> {

  String _textButton = "Check In!";
  MaterialColor _colorButton = Colors.green; //change once pressed the button
  MaterialColor _splashButton = Colors.red;
  bool _buttonState = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    )))));
  }

  void onButtonPressed() {
    setState(() {

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
