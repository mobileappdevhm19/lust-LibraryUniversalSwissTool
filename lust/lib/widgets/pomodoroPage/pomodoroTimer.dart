import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lust/pages/pomodoroPage.dart';

//FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


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
  PomodoroTimerState ptS;
  PomodoroTimer(int periodTime, int shortBreakTime, int longBreakTime, int countPeriods) {
    //flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    ptS=new PomodoroTimerState(periodTime, shortBreakTime, longBreakTime, countPeriods);
  }

  @override
  PomodoroTimerState createState() => ptS;
}

class PomodoroTimerState extends State<PomodoroTimer> {
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
  String resetBtnText="reset";
  ColorSwatch startStopBtnColor=Colors.green;
  //notifications notification;

  PomodoroTimerState(int periodTime, int shortBreakTime, int longBreakTime, int countPeriods) {
    statuslist.add(statusClass(-1, ""));
    statuslist.add(statusClass(periodTime, "actual you have to learn!"));
    statuslist.add(statusClass(shortBreakTime, "make a short break"));
    statuslist.add(statusClass(longBreakTime, "make a long break"));

    this.countPeriods = countPeriods;

    actStatusText=initialStatusText;
    setActTimeMinutesSeconds(); //so there stand 00:00 when start this page
  }

  @override
 /* initState() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    super.initState();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }*/


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
                    '$resetBtnText',
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
    if(actTimerSeconds==0){
      changeStatus();
    }
    else{
      startTimer();
    }
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


  /// starts timer
  /// set description Status text

  void changeStatus(){
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

    //showNormalNoti();
    startTimer();
  }


  void startTimer(){
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
        oneSec,
            (Timer timer) => setState(() {
              actTimerSeconds--;
          if (actTimerSeconds < 1) {
            timer.cancel();

            changeStatus();
          } else {
            setActTimeMinutesSeconds();
          }
        }),
    );
  }

  /*Future<void> showNormalNoti() async{
    await _showNotification();
  }*/

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

  /*Future<void> _showNotification() async {
    var vibrationPatternlist = Int64List(4);
    vibrationPatternlist[0] = 0;
    vibrationPatternlist[1] = 1000;
    vibrationPatternlist[2] = 5000;
    vibrationPatternlist[3] = 2000;

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker', vibrationPattern: vibrationPatternlist, enableVibration:  true);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'LUST', '$actStatusText', platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> onSelectNotification(String payload) async {
    /*if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    await Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (context) => PomodoroPage()),
    );*/
  }*/

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push<void>(
                context,
                MaterialPageRoute(
                //  builder: (context) => PomodoroPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }


  int getActTimerSeconds(){
    return actTimerSeconds;
  }

  void dispose() {
    super.dispose();
    if(_timer !=null){
      _timer.cancel();
    }
  }

}

