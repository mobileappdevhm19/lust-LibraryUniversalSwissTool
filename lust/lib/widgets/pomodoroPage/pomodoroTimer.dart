import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
//import 'package:lust/widgets/utils/notifications.dart';


enum Status{
  nothing, learning, shortBreak, longBreak
}

//like struct in c++
class statusClass {
  final int time;
  final String text;
  const statusClass(this.time, this.text);
}

class PomodoroTimer extends StatefulWidget {
  _PomodoroTimerState ptS;
  PomodoroTimer(int periodTime, int shortBreakTime, int longBreakTime, int countPeriods) {
      ptS=new _PomodoroTimerState(periodTime, shortBreakTime, longBreakTime, countPeriods);
  }

  @override
  _PomodoroTimerState createState() => ptS;
}

class _PomodoroTimerState extends State<PomodoroTimer> {

  static const MethodChannel _channel = MethodChannel('pomodoro');
  List<statusClass> statuslist=new List();
  int countPeriods;

  int actPeriod=0;
  int actTimerSeconds=0;
  String actTimeMinutesSeconds="";
  Status actStatus=Status.nothing; //initial
  String initialStatusText="Click on 'Start' to start the pomodoro timer";
  String actStatusText;

  Timer _timer;

  String startStopBtnText="Start";
  ColorSwatch startStopBtnColor=Colors.green;
  //notifications notification;

  _PomodoroTimerState(int periodTime, int shortBreakTime, int longBreakTime, int countPeriods) {
    statuslist.add(statusClass(-1, ""));
    statuslist.add(statusClass(periodTime, "actual you have to learn!"));
    statuslist.add(statusClass(shortBreakTime, "make a short break"));
    statuslist.add(statusClass(longBreakTime, "make a long break"));

    this.countPeriods = countPeriods;

    actStatusText=initialStatusText;
    setActTimeMinutesSeconds(); //so there stand 00:00 when start this page
    //notification=notifications();
  }

  Future<dynamic> myUtilsHandler(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'startTimer':
        startTimer();
        break;
      case 'changeStatus':
        changeStatus();
        break;
      default:
      // todo - throw not implemented
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Align(
        alignment: Alignment.center,
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width, //screen width
                height: 100.0,
                child:
                  RaisedButton(
                    color: startStopBtnColor,
                    onPressed: () {startStopButtonClicked();},
                    child: Text(
                        '$startStopBtnText',
                        style: TextStyle(fontSize: 40)
                    ),
                  )
              ),

              RaisedButton(
                onPressed: () {resetButtonClicked();},
                child: Text(
                    'reset',
                    style: TextStyle(fontSize: 20)
                ),
              ),

               Container(
               // color: Colors.blue,
                width: MediaQuery.of(context).size.width, //screen width
                height: 200.0,
                child: FittedBox(
                  fit: BoxFit.contain,
                    child: Text(
                      "$actTimeMinutesSeconds",
                      textScaleFactor: 0.8,
                      style: TextStyle(fontSize: 20.0, letterSpacing: 2.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                ),
              ),
              Expanded(child: Text(
                "$actStatusText",
                textScaleFactor: 0.8,
                style: TextStyle(fontSize: 20.0, letterSpacing: 2.0),
                textAlign: TextAlign.center,
              )),
            ],
         ),
        ),
    );
  }

  void startStopButtonClicked(){
    this.setState((){
      if(startStopBtnText=="Start"){
        start();
        return; //jut to leave this function
      }
      else{
        stop();
      }
    });
  }
  void stop(){
    startStopBtnText="Start";
    startStopBtnColor=Colors.green;
    if(_timer !=null){
      _timer.cancel();
    }
  }
  void start(){
    startStopBtnText="Stop";
    startStopBtnColor=Colors.red;
    _channel.invokeMethod<void>('changeStatus');
  }


  void resetButtonClicked(){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Reset Pomodoro"),
          content: new Text("Do you really want to reset the pomodoro timer?\n"
              "Are you sure that you can learn good without this feature of lust?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop(); //just close dialogwindow
              },
            ),
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("reset"),
              onPressed: () {
                actStatus=Status.nothing;
                actTimerSeconds=0;
                actPeriod=0;
                setState(() {
                  setActTimeMinutesSeconds(); //so there stand 00:00 when start this page
                  actStatusText=initialStatusText;
                });
                stop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  ///
  /// starts timer
  /// set description Status text

  void changeStatus() async{
    //necessary, otherwise multiple timer instances interfere each other


    actTimerSeconds=0;
    if(_timer !=null){
      _timer.cancel();
    }
    switch(actStatus){
      case Status.learning: {
        if(actPeriod>=countPeriods){
          actStatus=Status.longBreak;
          actPeriod=0; //start counting periods new
        }
        else{
          actStatus=Status.shortBreak;
        }
        break;
      }
      default: {
        actStatus=Status.learning;
        actPeriod++;
      }
    }


    actTimerSeconds=statuslist[actStatus.index].time;

    actStatusText=descriptionText();

    _channel.invokeMethod<void>('changeStatus');

    //startTimer();
  }

  void startTimer() async{
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
        oneSec,
            (Timer timer) => setState(() {
          if (actTimerSeconds < 1) {
            //timer.cancel();
            makeNoti();
            _channel.invokeMethod<void>('changeStatus');
          } else {
            actTimerSeconds --;
            setActTimeMinutesSeconds();
          }
        }),
    );
  }
  Future<void> makeNoti() async{
    //await notification.scheduleNotification();
  }
  void setActTimeMinutesSeconds(){
    int minutes=(actTimerSeconds/60).toInt();
    String minutesStirng=setFirst0(minutes);
    String secondsString=setFirst0(actTimerSeconds-(minutes*60));

    actTimeMinutesSeconds="$minutesStirng : $secondsString";
  }
  String setFirst0(int number){
    if(number<10){
      return "0$number";
    }
    else{
      return number.toString();
    }
  }

  String descriptionText(){
    String ret=statuslist[actStatus.index].text;
    ret +="\n";
    ret +=(countPeriods-actPeriod).toString() +"periods till next long break";
    return ret;
  }
}