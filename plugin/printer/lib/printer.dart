import 'dart:async';

import 'package:flutter/services.dart';

class Printer {
  static const MethodChannel _channel = const MethodChannel('printer_method');

   static const BasicMessageChannel<dynamic> runTimer = const BasicMessageChannel("printer_message", StandardMessageCodec());

  static void initMessageHandler() {
    print("initMessageHandler");
    runTimer.setMessageHandler((dynamic value) {
      // 接收到的时间
      int time = value;
      print("value = $time");
    });
  }
  
  static Future  printHello() async {
    final  version = await _channel.invokeMethod('printHello');
    return version;
  }
}
