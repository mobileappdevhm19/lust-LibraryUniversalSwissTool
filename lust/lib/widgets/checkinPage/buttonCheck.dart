import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lust/utils/locationAPI.dart';
import 'package:lust/widgets/utils/snackBar.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ButtonCheck extends StatefulWidget {
  ButtonCheck({this.scaffState});

  GlobalKey<ScaffoldState> scaffState;

  @override
  _ButtonCheckState createState() {
    return new _ButtonCheckState();
  }
}

enum ButtonEnable { ENABLE, DISABLED }

class _ButtonCheckState extends State<ButtonCheck> {
  GeoPoint _libHM;
  ButtonEnable status;

  final String BUTTONSTATE = 'BUTTONSTATE';

  String _textButton = "Check In!";
  String _textSnackBar="";
  MaterialColor _colorButton = Colors.green; //change once pressed the button
  MaterialColor _splashButton = Colors.red;
  bool _buttonState;

  final DocumentReference libReference =
      Firestore.instance.collection('lib_test').document('centralHM');
  final CollectionReference colRefLogin =
      Firestore.instance.collection('events');

  /*@override
  Future initState() async {
    super.initState();
    print('INIT STATE');

    locationAPI();
    getLibPosition();

    //status = await LocationAPI.getLocation(_libHM) == true ? ButtonEnable.ENABLE : ButtonEnable.DISABLED;
  }*/

  @override
  void initState() {
    getButtonState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 60),
        child: RawMaterialButton(
          //onPressed: onButtonPressed,
          onPressed: _onButtonPressed,
          child: Container(
            child: Text(
              _textButton,
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            alignment: Alignment.center,
            height: 120,
          ),
          padding: EdgeInsets.all(20),
          fillColor: _colorButton,
          splashColor: _splashButton,
          elevation: 3,
          shape: CircleBorder(
              side: BorderSide(
                  style: BorderStyle.solid, color: Colors.grey, width: 2)),
        ));
  }

  _showSnackBar() {
    print("BOTON!: $widget.scaffState");
    widget.scaffState.currentState.showSnackBar(SnackBar(
      content: Text(_textSnackBar),
    ));
  }

  void _onButtonPressed() async {
    await getLibPosition();
    _locationAPI();
    print('STATUS: $status & buttonState: $_buttonState');

    switch (status) {
      case ButtonEnable.ENABLE:
        setState(() {
          if (_buttonState == true) {
            _buttonState = false;
            _colorButton = Colors.green;
            _splashButton = Colors.red;
            _textButton = "Check In!";
            _textSnackBar = "Hope to see you soon again";
            sendEventToDB('logout');
          } else {
            _buttonState = true;
            _colorButton = Colors.red;
            _splashButton = Colors.green;
            _textButton = "Check out";
            _textSnackBar = "Succesfully checked in: WILLKOMMEN";
            sendEventToDB('login');
          }
        });
        await sendValueToDB(_buttonState); //only called if we are in the range
        break;

      case ButtonEnable.DISABLED:
        _textSnackBar =
            "You are too far from the lib!"; //PENDING: show distance!
        break;
    }
    _showSnackBar();
    saveButtonState();
  }

  Future sendValueToDB(bool increment) {
    int val = increment ? 1 : -1;
    // send new value to database
    return Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot postSnapshot = await tx.get(libReference);
      if (postSnapshot.exists) {
        await tx.update(libReference, <String, dynamic>{
          'occupancy': postSnapshot.data['occupancy'] + val
        });
      }
    });
  }

  Future sendEventToDB(String eventType) {
    Map<String, dynamic> data = {
      'eventType': eventType,
      'time': DateTime.now()
    };
    return colRefLogin.document().setData(data);
    //await tx.update(postRef, <String, dynamic>{'occupancy': postSnapshot.data['occupancy'] + val});
  }

  Future getLibPosition() {
    libReference.get().then((DocumentSnapshot document) {
      _libHM = document['location'];
    });
    print('HM coordinates: (${_libHM.latitude}, ${_libHM.longitude})');
  }

  _locationAPI() async {
    if (await LocationAPI.getLocation(_libHM)) {
      status = ButtonEnable.ENABLE;
    } else {
      status = ButtonEnable.DISABLED;
    }
    print('STATUS: $status');
  }

  // Checks if there is already a state stored
  // If nothing is stored -> sets state to false
  // If state exists takes the old value and sets the state
  void getButtonState() async {
    bool tempState;
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool(BUTTONSTATE) == null) {
      tempState = false;
      //pref.setBool(BUTTONSTATE, tempState);
    } else {
      tempState = pref.getBool(BUTTONSTATE);
    }
    setState(() {
      _buttonState = tempState;
      updatePageFromState(_buttonState);
    });
  }

  // Saves the current button state to the device
  // so that it can be fetched again
  void saveButtonState() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(BUTTONSTATE, _buttonState);
  }

  // Puts the correct appearance to the button
  // depending on the boolean state of the button
  void updatePageFromState(bool state) {
    if (state) {
      _colorButton = Colors.red;
      _splashButton = Colors.green;
      _textButton = "Check out";
    } else {
      _colorButton = Colors.green;
      _splashButton = Colors.red;
      _textButton = "Check In!";
    }
  }
}
