import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonLogin extends StatefulWidget {
  final String buttonText;
  final bool whichButton;
  final Color buttonColor;
  final Function function;

  const ButtonLogin(
      {Key key, this.buttonText, this.whichButton, this.buttonColor, this.function})
      : super(key: key);

  @override
  _ButtonLoginState createState() {
    return new _ButtonLoginState(buttonText, whichButton, buttonColor, function);
  }
}

class _ButtonLoginState extends State<ButtonLogin> {
  final String buttonText;
  final bool whichButton;
  final Color buttonColor;
  final Function function;

  _ButtonLoginState(this.buttonText, this.whichButton, this.buttonColor,
      this.function);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10, left: 30, right: 30),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: RawMaterialButton(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30)),
            fillColor: buttonColor,
            child: Text(
              buttonText,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: function, // _buttonClicked(whichButton),
          ),
        ));
  }
}