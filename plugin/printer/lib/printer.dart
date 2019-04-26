import 'dart:async';

import 'package:flutter/services.dart';

typedef void MessageCallBack(dynamic value);

class Printer {
  static const MethodChannel _channel =
      const MethodChannel('plugins.flutter.io/printer_method');

  static const BasicMessageChannel<dynamic> dataSource =
      const BasicMessageChannel(
          "plugins.flutter.io/printer_message", StandardMessageCodec());

  static void init(MessageCallBack callBack) {
    dataSource.setMessageHandler((dynamic value) {
      callBack(value);
    });
  }

  static Future start() async {
    try {
      return await _channel.invokeMethod('start');
    } catch (e) {}
  }

  static Future stop() async {
    try {
      return await _channel.invokeMethod('stop');
    } catch (e) {}
  }

  static Future print(Map args) async {
    try {
      return await _channel.invokeMethod('print', args);
    } catch (e) {}
  }

  static Future connect(String uuid) async {
    try {
      return await _channel.invokeMethod('connect', uuid);
    } catch (e) {}
  }
}
