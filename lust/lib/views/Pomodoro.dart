import 'package:flutter/material.dart';
import 'package:lust/widgets/widgetCreator.dart';



class Pomodoro extends StatefulWidget {
  @override
  _PomodoroState createState() => new _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  final _title = "Pomodoro";

  @override
  Widget build(BuildContext context) {

    var _height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        drawer: WidgetCreator.getDrawer(context),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: _height*0.60,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10.0),
                )
              ]),
        ));
  } // build

}
