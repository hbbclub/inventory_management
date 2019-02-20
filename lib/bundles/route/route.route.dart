import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'route.route.internal.dart';

class RouterPageOption {
  String url;
  Map<String, dynamic> query;
  Map<String, dynamic> params;
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
      option,
    );
    if (routeResult.state == ARouterResultState.FOUND) {
      return routeResult.widget;
    }
    return Container(
      child: Text('error: can\'t find a page'),
    );
  }
}
