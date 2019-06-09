// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';
import 'package:lust/pages/capacityPage.dart';
import 'package:lust/pages/checkinPage.dart';
import 'package:lust/pages/loginPage.dart';
import 'package:lust/pages/rootPage.dart';
import 'package:lust/utils/autenthicationAPI.dart';

void main() => runApp(Lust());

class Lust extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Code Sample for material.AppBar.actions',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootPage(auth: new Auth())
        //home: LoginPage(auth: new Auth())
        //home: CapacityPage(); //(just to solve the tests problems)
        );
  }
}
