import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lust/pages/utils/authProvider.dart';
import 'package:lust/widgets/checkinPage/buttonCheck.dart';
import 'package:lust/widgets/utils/getAppBar.dart';
import 'package:lust/widgets/utils/getTextBox.dart';

import 'package:lust/widgets/utils/menuDrawer.dart';

import '../rootPage.dart';

class CheckinPage extends StatefulWidget {
  CheckinPage({this.onSignedOut});

  VoidCallback onSignedOut;

  static String title = "Check In/Out";
  static IconData icon = Icons.check_circle_outline;

  @override
  _CheckinPageState createState() => _CheckinPageState(title, icon);
}

class _CheckinPageState extends State<CheckinPage> {
  final String title;
  final icon;

  String _subjectInput;
  String _lockerNumber, _timeGoal;

  final GlobalKey<ScaffoldState> _scaffState = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final double _appBarHeight = 55;

  _CheckinPageState(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    _height -= 85;

    return Scaffold(
        key: _scaffState,
        appBar: PreferredSize(
            child: GetAppBar(title, _signOut),
            preferredSize: Size.fromHeight(_appBarHeight)),
        drawer: MenuDrawer(context),
        body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.local_library, size: 35),
                    title: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Subject",
                        //labelStyle: TextStyle(fontSize: 16, color: Colors.black45),
                        hintText: "Good luck with that!",
                        //hintStyle: TextStyle(fontSize: 13, color: Colors.black12),
                      ),
                      /*validator: (input) =>
                      input.isEmpty ? "Please write your email" : null,*/
                      keyboardType: TextInputType.text,
                      onSaved: (input) => _subjectInput = input,
                    )),
                ListTile(
                    leading: Icon(Icons.timer, size: 35),
                    title: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Time goal",
                        //labelStyle: TextStyle(fontSize: 16, color: Colors.black45),
                        hintText: "Be realistic!",
                        //hintStyle: TextStyle(fontSize: 13, color: Colors.black12),
                      ),
                      /*validator: (input) =>
                      input.isEmpty ? "Please write your email" : null,*/
                      keyboardType: TextInputType.number,
                      onSaved: (input) => _timeGoal = input,
                    )),
                ListTile(
                    leading: Icon(Icons.lock, size: 35),
                    title: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Locker number",
                        //labelStyle: TextStyle(fontSize: 16, color: Colors.black45),
                        hintText: "I know it's difficult to remember",
                        //hintStyle: TextStyle(fontSize: 13, color: Colors.black12),
                      ),
                      validator: (input) => null,
                      keyboardType: TextInputType.number,
                      onSaved: (input) => _lockerNumber = input,
                    )),
                Container(
                  alignment: Alignment.center,
                  height: _height * 0.6,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: ButtonCheck(
                      scaffState: _scaffState, function: _checkTextFields),
                ),
              ],
            )));
  }

  bool _checkTextFields() {
    var _storeNumber = AuthProvider.of(context).lockerNumber;
    _storeNumber.changeNumber(_lockerNumber);

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("FORM OK: ${_storeNumber.lockerNumber}");
      return true;
    } else {
      print("FORM WRONG: the fields cannot be empty");
      return false;
    }
  }

  void _signOut() {
    var auth = AuthProvider.of(context).auth;
    print("CURRENT USER: mateo mateo");
    try {
      auth.signOut();
      MenuDrawer.switchPage(context, RootPage());
    } catch (e) {
      print(e);
    }
  }
}
