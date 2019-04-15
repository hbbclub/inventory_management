import 'dart:async';

import 'package:flutter/services.dart';

typedef void MessageCallBack(dynamic value) ;

class Printer {
  static const MethodChannel _channel =
      const MethodChannel('plugins.flutter.io/printer_method');

  static const BasicMessageChannel<dynamic> dataSource =
      const BasicMessageChannel(
          "plugins.flutter.io/printer_message",
          StandardMessageCodec());

  static void  init(MessageCallBack callBack) {
    dataSource.setMessageHandler((dynamic value) {
      callBack(value);
    });
  }

  static Future start() async {
    return await _channel.invokeMethod('start');
  }

  static Future stop() async {
    return await _channel.invokeMethod('stop');
  }

  static Future connect(String uuid) async {
    return await _channel.invokeMethod('connect', uuid);
  }
}
