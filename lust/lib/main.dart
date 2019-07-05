// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';
import 'package:lust/pages/capacityPage/capacityPage.dart';
import 'package:lust/pages/checkinPage/checkinPage.dart';
import 'package:lust/pages/loginPage/loginPage.dart';
import 'package:lust/pages/rootPage.dart';
import 'package:lust/pages/utils/authProvider.dart';
import 'package:lust/utils/autenthicationAPI.dart';
import 'package:lust/pages/pomodoroPage/pomodoroPage.dart';

import 'models/lockerNumber.dart';

void main() async => runApp(Lust());

class Lust extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
        auth: new Auth(),
        lockerNumber: new LockerNumber(lockerNumber: "not specified"),
        child: MaterialApp(
            title: 'LUST',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: RootPage()));
  }
}
