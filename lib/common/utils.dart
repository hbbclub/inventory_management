import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ScreenUtil initScreenUtil(context) {
  return ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)
    ..init(context);
}

double h(int height) {
  return ScreenUtil().setHeight(height);
}

double w(int width) {
  return ScreenUtil().setWidth(width);
}

double sp(size) {
  return ScreenUtil().setSp(size);
}

class Utils {
  //应用名称
  static const String appName = 'inventory_management';
  static String appVersion = '';
  

//******************计算******** */
  // 返回当前时间戳
  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  //当前事件戳 增加acc
  static int currentTimeMillisAccumulation(int acc) {
    return new DateTime.now().millisecondsSinceEpoch + acc;
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

//**********************UI******************* */
  // 获取屏幕宽度
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // 获取屏幕高度
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

//获取设备uuid
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

  //获取应用版本号
  static Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  // 获取系统状态栏高度
  static double getSysStatsHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

//******************页面******************** */
//   // 页面跳转
//   static Future pushScreen(BuildContext context, Widget screen) {
//     return Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (BuildContext context) {
//           return screen;
//         },
//       ),
//     );
//   }

// //替换当前页面
//   static Future replaceScreen(BuildContext context, Widget screen) {
//     return Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (BuildContext context) {
//           return screen;
//         },
//       ),
//     );
//   }

// //pop页面站知道只有一个页面
//   static void popAll(BuildContext context) {
//     Navigator.of(context).popUntil((Route router) {
//       print(router.isFirst);
//       if (router.isFirst) {
//         return true;
//       }
//       return false;
//     });
//   }

// //推出指定个数页面
//   static void popNum(BuildContext context, int number) {
//     int i = 0;
//     Navigator.of(context).popUntil((Route router) {
//       if ((router.isFirst) || (i == number)) {
//         return true;
//       }
//       i++;
//       return false;
//     });
//   }

//显示提示框
  static showSnackBar(BuildContext context,
      {@required String text, int duration}) {
    final snackBar = SnackBar(
      content: new Text(text ?? ' '),
      duration: Duration(seconds: duration ?? 1),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

//显示提示框通过key
  static showSnackBarWithKey(GlobalKey<ScaffoldState> key,
      {@required String text, int duration}) {
    final snackBar = SnackBar(
      content: new Text(text ?? ' '),
      duration: Duration(seconds: duration ?? 1),
    );
    key.currentState.showSnackBar(snackBar);
  }
}
