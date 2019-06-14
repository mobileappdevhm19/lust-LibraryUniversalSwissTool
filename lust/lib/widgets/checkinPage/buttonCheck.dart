import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lust/utils/locationAPI.dart';

class ButtonCheck extends StatefulWidget {
  @override
  _ButtonCheckState createState() => _ButtonCheckState();
}

class _ButtonCheckState extends State<ButtonCheck> {
  //PROVISIONAL
  final String bibLat = 'latitude';
  final String bibLon = 'longitude';
  String snapLat, snapLon;
  final DocumentReference documentHM =
  Firestore.instance.collection('libs').document('centralHM');
  //PROVISIONAL


  String _textButton = "Check In!";
  MaterialColor _colorButton = Colors.green; //change once pressed the button
  MaterialColor _splashButton = Colors.red;
  bool _buttonState = false;

  final DocumentReference postRefOccupancy =
      Firestore.instance.collection('lib_test').document('centralHM');
  final CollectionReference colRefLogin =
      Firestore.instance.collection('events');

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 60),
        child: RawMaterialButton(
          onPressed: onButtonPressed,
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

  void onButtonPressed() async {
    String distance = await getLib();
    print(distance);
    print('hehehe: $distance');

    setState(() {
      if (_buttonState == true) {
        _buttonState = false;
        _colorButton = Colors.green;
        _splashButton = Colors.red;
        _textButton = "Check In!";
        sendEventToDB('logout');
      } else {
        _buttonState = true;
        _colorButton = Colors.red;
        _splashButton = Colors.green;
        _textButton = "Check out";
        sendEventToDB('login');
      }
    });
    await sendValueToDB(_buttonState);
  }

  Future sendValueToDB(bool increment) {
    int val = increment ? 1 : -1;
    // send new value to database
    return Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot postSnapshot = await tx.get(postRefOccupancy);
      if (postSnapshot.exists) {
        await tx.update(postRefOccupancy, <String, dynamic>{
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

  //PROVISIONAL
  Future getLib() {
    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot snapshot = await tx.get(documentHM);
      if (snapshot.exists) {
        snapLat = await snapshot.data[bibLat].toString();
        snapLon = await snapshot.data[bibLon].toString();
      }
      return snapLat;
    });
  }
  //PROVISIONAL

}
