import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'package:inventory_management/bundles/login/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  //应用名称
  static String appName = 'inventory_management';
  //api
  static String hostUri = 'http://mm.xwcbpx.com';
  static String linkWord = '';
  //user
  static UserModel user = UserModel();
  //cache key
  static String cacheKey = 'LOCAL_CACHE';
  static String cacheKeyForHostUrl = 'LOCAL_CACHE_HOST_URL';
  static String cacheKeyForLinkWord = 'LOCAL_CACHE_LINK_WORD';
  static String cacheKeyForUsername = 'LOCAL_CACHE_USERNAME';
  static String cacheKeyForPassword = 'LOCAL_CACHE_PASSWORD';

  // 返回当前时间戳
  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  // 返回当前时间字符串 年月日 YYYY年MM月DD日
  static String dateformatWithYYYYMMDD(int timeStamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    return '${date.year}年${date.month}月${date.day}日';
  }

  // 返回当前时间字符串 时分秒 hh:mm:ss
  static String dateformatWithHHMMSS(int timeStamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    return '${date.hour}:${date.minute}:${date.second}';
  }

  // 复制到剪粘板
  static copyToClipboard(final String text) {
    if (text == null) return;
    Clipboard.setData(new ClipboardData(text: text));
  }

  static const RollupSize_Units = ["GB", "MB", "KB", "B"];
  // 返回文件大小字符串
  static String getRollupSize(int size) {
    int idx = 3;
    int r1 = 0;
    String result = "";
    while (idx >= 0) {
      int s1 = size % 1024;
      size = size >> 10;
      if (size == 0 || idx == 0) {
        r1 = (r1 * 100) ~/ 1024;
        if (r1 > 0) {
          if (r1 >= 10)
            result = "$s1.$r1${RollupSize_Units[idx]}";
          else
            result = "$s1.0$r1${RollupSize_Units[idx]}";
        } else
          result = s1.toString() + RollupSize_Units[idx];
        break;
      }
      r1 = s1;
      idx--;
    }
    return result;
  }

// 返回两个日期相差的天数
  static int daysBetween(DateTime a, DateTime b, [bool ignoreTime = false]) {
    if (ignoreTime) {
      int v = a.millisecondsSinceEpoch ~/ 86400000 -
          b.millisecondsSinceEpoch ~/ 86400000;
      if (v < 0) return -v;
      return v;
    } else {
      int v = a.millisecondsSinceEpoch - b.millisecondsSinceEpoch;
      if (v < 0) v = -v;
      return v ~/ 86400000;
    }
  }

  // 获取屏幕宽度
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // 获取屏幕高度
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // 获取系统状态栏高度
  static double getSysStatsHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  // 页面跳转
  static Future pushScreen(BuildContext context, Widget screen) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return screen;
        },
      ),
    );
  }

  static Future replaceScreen(BuildContext context, Widget screen) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return screen;
        },
      ),
    );
  }

  static void popAll(BuildContext context) {
    Navigator.of(context).popUntil((Route router) {
      print(router.isFirst);
      if (router.isFirst) {
        return true;
      }
      return false;
    });
  }

  static Future<String> getDeviceUUID() async {
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.fingerprint;
    }
    return null;
  }

  static showSnackBar(BuildContext context,
      {@required String text, int duration}) {
    final snackBar = SnackBar(
      content: new Text(text ?? ' '),
      duration: Duration(seconds: duration ?? 1),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  static Future<Map<String, dynamic>> getLoaclCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rawJson = prefs.getString(Utils.cacheKey);
    if (rawJson == null) {
      return {};
    }
    return json.decode(rawJson);
  }

  //会将参数的map融合到本地缓存的json对象中
  static Future<bool> addLoaclCache(Map<String, dynamic> cacheMap) async {
    if (cacheMap == null) {
      return false;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map cache = await Utils.getLoaclCache();
    cache.addAll(cacheMap);
    return prefs.setString(Utils.cacheKey, json.encode(cache));
  }
}
