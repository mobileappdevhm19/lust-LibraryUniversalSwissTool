import 'package:flutter/material.dart';
import 'package:lust/widgets/pomodoroPage/pomodoroDescription.dart';



class PomodoroPage extends StatefulWidget {
  @override
  _PomodoroState createState() => new _PomodoroState();
}

class _PomodoroState extends State<PomodoroPage> {
  final _title = "Pomodoro";

  @override
  Widget build(BuildContext context) {

    var _height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: _height*0.40,
                  child: new pomodoroDescription(),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10.0),
                )
              ]),
        ));
  } // build

}


/*

/**
 * this function returns the container with the description of the parameters
 **/
Widget promDesc(){
  return new Container(
    child: Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Row(
          children: <Widget>[
            const Expanded(child: Text(
              "period:",
              textScaleFactor: 0.8,
              style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
              textAlign: TextAlign.center,
            )),
            const Expanded(child: Text(
              "25 min",
              textScaleFactor: 0.8,
              style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
              textAlign: TextAlign.center,
            )),
          ],
        ),
        new Divider(
          height: 50.0,
          indent: 0.0,
          color: Colors.black,
        ),
        new Row(
          children: <Widget>[
            const Expanded(child: Text(
              "break:",
              textScaleFactor: 0.8,
              style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
              textAlign: TextAlign.center,
            )),
            const Expanded(child: Text(
              "5 / 15 min",
              textScaleFactor: 0.8,
              style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
              textAlign: TextAlign.center,
            )),
          ],
        ),
        new Divider(
          height: 50.0,
          indent: 0.0,
          color: Colors.black,
        ),
        new Row(
          children: <Widget>[
            const Expanded(child: Text(
              "periods:",
              textScaleFactor: 0.8,
              style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
              textAlign: TextAlign.center,
            )),
            const Expanded(child: Text(
              "4",
              textScaleFactor: 0.8,
              style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
              textAlign: TextAlign.center,
            )),
          ],
        ),
    ]),
  );

}*/