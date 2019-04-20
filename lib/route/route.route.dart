import 'package:annotation_route/route.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'route.route.internal.dart';

class RouterPageOption {
  String url;
  Map<String, dynamic> query;
  dynamic params;
  RouterPageOption({this.url, this.query, this.params});
}

@ARouteRoot()
class MyRouter {
  ARouterInternal internal = ARouterInternalImpl();
  Widget findPage(RouterPageOption option) {
    ARouterResult routeResult = internal.findPage(
        ARouteOption(
          option.url,
          option.query,
        ),
        option.params);
    if (routeResult.state == ARouterResultState.FOUND) {
      return routeResult.widget;
    }
    return throw ArgumentError('The page can not be find');
  }

  Page takePage(RouterPageOption option) {
    ARouterResult routeResult = internal.findPage(
        ARouteOption(
          option.url,
          option.query,
        ),
        option.params);
    if (routeResult.state == ARouterResultState.FOUND) {
      return routeResult.widget;
    }
    return throw ArgumentError('The page can not be find');
  }

  // 页面跳转
  Future pushScreen(BuildContext context, RouterPageOption option) {
    Page screen = takePage(option);

    return Navigator.of(context).push(
      MaterialPageRoute(
        settings: RouteSettings(name: option.url),
        builder: (BuildContext context) {
          return screen.buildPage(option.params ?? Map<String, dynamic>());
        },
      ),
    );
  }

  // 页面弹出
  bool popScreen<T>(BuildContext context, [T result]) {
    return Navigator.of(context).pop<T>(result);
  }

//替换当前页面
  Future replaceScreen(BuildContext context, RouterPageOption option) {
    Page screen = takePage(option);
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        settings: RouteSettings(name: option.url),
        builder: (BuildContext context) {
          return screen.buildPage(option.params ?? Map<String, dynamic>());
        },
      ),
    );
  }

//pop页面站知道只有一个页面
  void popAll(BuildContext context) {
    Navigator.of(context).popUntil((Route router) {
      print(router.isFirst);
      if (router.isFirst) {
        return true;
      }
      return false;
    });
  }

//推出指定个数页面
  void popNum(BuildContext context, int number) {
    int i = 0;
    Navigator.of(context).popUntil((Route router) {
      if ((router.isFirst) || (i == number)) {
        return true;
      }
      i++;
      return false;
    });
  }

  void popUtil(BuildContext context, String url) {
    Navigator.of(context).popUntil((Route route) => route.settings.name == url);
  }
}

final MyRouter router = MyRouter();


