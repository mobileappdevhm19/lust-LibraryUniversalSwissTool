import 'dart:async';
import 'package:flutter/services.dart';

enum Status{
  nothing, learning, shortBreak, longBreak
}

class FlutterLibraryUniversalSwissToolPlugin {

  static int countPeriods;

  static int actPeriod=0;
  static int actTimerSeconds=0;

  static Timer _timer;
  static Status actStatus;
  static List<int> timeList;

  static void setTimeList(List<int> list){
    timeList=list;
  }

  static Future<int>get getActTimerSeconds async{
    return actTimerSeconds;
  }

  static const MethodChannel _channel =
      const MethodChannel('flutter_library_universal_swiss_tool_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }



  static Future<void> startTimer(){
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => print(() { //print is necassary ?
        if (actTimerSeconds < 1) {
          //timer.cancel();
          _channel.invokeMethod<void>('changeStatus');
        } else {
          actTimerSeconds --;
          //setActTimeMinutesSeconds();
        }
      }),
    );
  }

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


    actTimerSeconds=timeList[actStatus.index];

    startTimer();
  }


}
