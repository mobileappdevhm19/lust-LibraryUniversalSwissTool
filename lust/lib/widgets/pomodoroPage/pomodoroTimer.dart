import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lust/pages/pomodoroPage/pomodoroPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

//FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

enum Status { nothing, learning, shortBreak, longBreak }

const StartTime_KEY = "startTime";
const IsRunning_KEY = "isRunning";
const StopTime_KEY = "stopTime";
const ActStatus_KEY = "actStatus";
const ActPeriod_KEY = "actPeriod";
const OldTimerSeconds_KEY = "oldTimerSeconds";

//like struct in c++
class statusClass {
  final int time;
  final String text;

  const statusClass(this.time, this.text);
}

class PomodoroTimer extends StatefulWidget {
  PomodoroTimerState ptS;

  int countPeriods;
  List<statusClass> statuslist = new List();

  /*PomodoroTimer(int periodTime, int shortBreakTime, int longBreakTime, int countPeriods) {
    this.countPeriods=countPeriods;
    //flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    ptS=new PomodoroTimerState(periodTime, shortBreakTime, longBreakTime, countPeriods);
  } */

  PomodoroTimer(
      int periodTime, int shortBreakTime, int longBreakTime, int countPeriods) {
    statuslist.add(statusClass(-1, ""));
    statuslist.add(statusClass(periodTime * 60, "actual you have to learn!"));
    statuslist.add(statusClass(shortBreakTime * 60, "make a short break"));
    statuslist.add(statusClass(longBreakTime * 60, "make a long break"));

    this.countPeriods = countPeriods;
    ptS = new PomodoroTimerState();
  }

  @override
  PomodoroTimerState createState() => ptS;
}

class PomodoroTimerState extends State<PomodoroTimer> {
  List<statusClass> statuslist = new List();
  int countPeriods;

  int actPeriod;
  int actTimerSeconds;
  String actTimeMinutesSeconds = "";
  Status actStatus; //=Status.nothing; //initial
  String initialStatusText = "Click on 'Start' to start the pomodoro timer";
  String actStatusText;
  int startTime;
  bool isRunning = false;
  int stopTime; //sec, since 1970, set, when stopButton clicked

  Timer _timer;

  String startStopBtnText = "Start";
  String resetBtnText = "reset";
  ColorSwatch startStopBtnColor = Colors.green;

  //notifications notification;

  @override
  void initState() {
    super.initState();

    if (widget != null) {
      this.countPeriods = widget.countPeriods;
      this.statuslist = widget.statuslist;
    } else {
      //only for testing
      print("in test Constructor in PomodoroTimerState");
      statuslist.add(statusClass(-1, ""));
      statuslist.add(statusClass(25, "actual you have to learn!"));
      statuslist.add(statusClass(9, "make a short break"));
      statuslist.add(statusClass(15, "make a long break"));

      this.countPeriods = 3;
      this.statuslist = statuslist;

      int actTime = new DateTime.now().millisecondsSinceEpoch;
      actTime = (actTime / 1000).toInt();
      startTime = actTime;
      actTimerSeconds = 0;
      isRunning = false; //when no seconds count, the timer cannot be started
      actStatus = Status.nothing; //initial
      actStatusText = initialStatusText;
      setActTimeMinutesSeconds(); //for 00:00 at first
      return;
    }

    //actTimerSeconds=0;
    setActTimeMinutesSeconds(); //for 00:00 at first

    initPlatformState();
  }

  Future<void> initPlatformState() async {
    setActTimeMinutesSeconds(); //for 00:00 at first
    // Load persisted fetch events from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int actTime = new DateTime.now().millisecondsSinceEpoch;
    actTime = (actTime / 1000).toInt();
    startTime = prefs.getInt(StartTime_KEY);
    int oldTimerSeconds = prefs.getInt(OldTimerSeconds_KEY);

    /*setState(() {
      actErrors += "startTime $startTime \n";
    });*/

    int stopT = prefs.getInt(StopTime_KEY);
    if (stopT != null) {
      stopTime = stopT;
    } else {
      stopTime = actTime;
    }
    /*setState(() {
      actErrors += "stop $stopTime \n";
    });*/

    if (startTime != null) {
      setState(() {
        setActTimeMinutesSeconds();
      });

      isRunning = prefs.getBool(IsRunning_KEY);
      actStatus = Status.values[prefs.getInt(ActStatus_KEY)];
      actPeriod = prefs.getInt(ActPeriod_KEY);
      if (isRunning) {
        if (_timer != null) {
          _timer.cancel(); //stop timer if exist
        }
        startStopBtnText = "Stop";
        startStopBtnColor = Colors.red;

        int difTime = (actTime - startTime);
        if (difTime < statuslist[actStatus.index].time) {
          actTimerSeconds = statuslist[actStatus.index].time - difTime;
        } else {
          //only varibles for this loop to find out which time in the actual status we have
          Status hereStatus = actStatus;
          int hereTimerSeconds = difTime;
          int herePeriod = actPeriod;
          while (hereTimerSeconds > 0) {
            //because in the background maybe a few periods passed

            int oldTimerSec = hereTimerSeconds;
            int oldPeriod = herePeriod;
            switch (hereStatus) {
              case Status.learning:
                {
                  if (herePeriod >= countPeriods) {
                    hereStatus = Status.longBreak;
                    herePeriod = 0; //start counting periods new
                  } else {
                    hereStatus = Status.shortBreak;
                  }
                  break;
                }
              default:
                {
                  hereStatus = Status.learning;
                  herePeriod++;
                }
            }

            hereTimerSeconds =
                hereTimerSeconds - statuslist[hereStatus.index].time;

            print("actTimerSeconds $hereTimerSeconds");
            if (hereTimerSeconds < 0) {
              hereTimerSeconds = oldTimerSec;
              actPeriod = oldPeriod;
              break;
            }
          }
          actTimerSeconds = hereTimerSeconds;
        }

        actStatusText = descriptionText();
        startTimer(); //start Timer with actual values
      } else {
        //actual stopped

        actTimerSeconds =
            oldTimerSeconds; //subtrac the time beetween last stop click and now
        print("act Status $actStatus");
        actStatusText = descriptionText();
      }
    } else {
      //startTime =null
      startTime = actTime;
      actTimerSeconds = 0;
      prefs.setInt(OldTimerSeconds_KEY, actTimerSeconds);
      isRunning = false; //when no seconds count, the timer cannot be started
      actStatus = Status.nothing; //initial
      actStatusText = initialStatusText;
    }

    setState(() {
      setActTimeMinutesSeconds();
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
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
                child: RaisedButton(
                  color: startStopBtnColor,
                  onPressed: () {
                    startStopButtonClicked();
                  },
                  child:
                      Text('$startStopBtnText', style: TextStyle(fontSize: 40)),
                )),
            RaisedButton(
              onPressed: () {
                resetButtonClicked();
              },
              child: Text('$resetBtnText', style: TextStyle(fontSize: 20)),
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
                    style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
            ),
            Expanded(
                child: Text(
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

  void startStopButtonClicked() {
    this.setState(() {
      if (startStopBtnText == "Start") {
        start();
        return; //jut to leave this function
      } else {
        stop();
      }
    });
  }

  void stop() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //if(isRunning){
    setState(() {
      startStopBtnText = "Start";
      startStopBtnColor = Colors.green;
    });
    if (_timer != null) {
      _timer.cancel(); //stop timer if exist
    }
    // }
    isRunning = false;

    //for background

    prefs.setBool(IsRunning_KEY, isRunning);
    int actTime = new DateTime.now().millisecondsSinceEpoch;
    actTime = (actTime / 1000).toInt();
    stopTime = actTime;
    startTime = startTime - actTimerSeconds;
    /*setState(() {
      actErrors += "startTime $startTime \n";
    });*/
    prefs.setInt(StopTime_KEY, stopTime);
    prefs.setInt(OldTimerSeconds_KEY, actTimerSeconds);
  }

  void start() async {
    setState(() {
      startStopBtnText = "Stop";
      startStopBtnColor = Colors.red;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int actTime = new DateTime.now().millisecondsSinceEpoch;
    actTime = (actTime / 1000).toInt();
    startTime = actTime - actTimerSeconds;

    prefs.setInt(StartTime_KEY, startTime);
    prefs.setBool(IsRunning_KEY, true);
    isRunning = true;
    //print("pomTimerState start is running: $isRunning");
    startTimer(); //start a new timer
  }

  void resetButtonClicked() {
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
                actStatus = Status.nothing;
                actTimerSeconds = 0;
                actPeriod = 0;
                setState(() {
                  setActTimeMinutesSeconds(); //so there stand 00:00 when start this page
                  actStatusText = initialStatusText;
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

  void changeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //necessary, otherwise multiple timer instances interfere each other

    actTimerSeconds = 0;
    if (_timer != null) {
      _timer.cancel();
    }
    switch (actStatus) {
      case Status.learning:
        {
          if (actPeriod >= countPeriods) {
            actStatus = Status.longBreak;
            actPeriod = 0; //start counting periods new
          } else {
            actStatus = Status.shortBreak;
          }
          break;
        }
      default:
        {
          actStatus = Status.learning;
          actPeriod++;
        }
    }

    prefs.setInt(ActPeriod_KEY, actPeriod);

    actTimerSeconds = statuslist[actStatus.index].time;
    prefs.setInt(OldTimerSeconds_KEY, actTimerSeconds);

    prefs.setInt(ActStatus_KEY, actStatus.index);

    actStatusText = descriptionText();

    //showNormalNoti()
    startTimer();
  }

  void startTimer() async {
    //for background
    SharedPreferences prefs = await SharedPreferences.getInstance();

    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(() {
            actTimerSeconds--;
            prefs.setInt(OldTimerSeconds_KEY, actTimerSeconds);

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

  ///only for textual output
  void setActTimeMinutesSeconds() {
    if (actTimerSeconds == null) {
      actTimerSeconds = 0;
    }

    int minutes = (actTimerSeconds / 60).toInt();
    String minutesString = setFirst0(minutes);
    String secondsString = setFirst0(actTimerSeconds - (minutes * 60));

    actTimeMinutesSeconds = "$minutesString : $secondsString";
    //return actTimeMinutesSeconds;
  }

  String setFirst0(int number) {
    if (number < 10) {
      return "0$number";
    } else {
      return number.toString();
    }
  }

  String descriptionText() {
    String ret = statuslist[actStatus.index].text;
    ret += "\n";
    ret +=
        (countPeriods - actPeriod).toString() + "periods till next long break";
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

  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }

    /*SharedPreferences prefs = await SharedPreferences.getInstance();
    int actTime = new DateTime.now().millisecondsSinceEpoch;
    actTime = (actTime / 1000).toInt();
    startTime=actTime-actTimerSeconds;

    prefs.setInt(StartTime_KEY, startTime); */
  }
}
