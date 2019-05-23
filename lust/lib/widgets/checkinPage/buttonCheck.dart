import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ButtonCheck extends StatefulWidget {
  @override
  _ButtonCheckState createState() => _ButtonCheckState();
}

class _ButtonCheckState extends State<ButtonCheck> {
  String _textButton = "Check In!";
  MaterialColor _colorButton = Colors.green; //change once pressed the button
  MaterialColor _splashButton = Colors.red;
  bool _buttonState = false;

  final DocumentReference postRef = Firestore.instance.collection('lib_test').document('centralHM');

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
                        borderRadius: BorderRadius.circular(150),
                        color: _colorButton),
                    child: Center(
                        child: Text(
                      _textButton,
                      style: TextStyle(fontSize: 28),
                    )))));
  }

  void onButtonPressed() async {
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
    await sendValueToDB(_buttonState);
  }

  Future sendValueToDB(bool increment) {
    int val = increment ? 1 : -1;
    // send new value to database
    return Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot postSnapshot = await tx.get(postRef);
      if (postSnapshot.exists) {
        await tx.update(postRef, <String, dynamic>{'occupancy': postSnapshot.data['occupancy'] + val});
      }
    });
  }
}
