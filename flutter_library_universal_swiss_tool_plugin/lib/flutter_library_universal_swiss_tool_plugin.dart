import 'dart:async';

import 'package:flutter/services.dart';

class FlutterLibraryUniversalSwissToolPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_library_universal_swiss_tool_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> startTimer(int actTimerSeconds){
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

}
