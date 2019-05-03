import 'package:flutter/material.dart';
import 'package:lust/views/capacityPage.dart';

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
      home: CapacityPage(),
    );
  }
}
