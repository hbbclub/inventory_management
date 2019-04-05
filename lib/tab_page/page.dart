import 'package:annotation_route/route.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class IndexComponentState extends ComponentState<TabState>
    with TickerProviderStateMixin {}

const routerNameForTabPage = 'router://TabPage';
@ARoute(url: routerNameForTabPage)
class TabPage extends Page<TabState, Map<String, dynamic>> {
  @override
  IndexComponentState createState() => IndexComponentState();

  TabPage(param)
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TabState>(
              adapter: null, slots: <String, Dependent<TabState>>{}),
          middleware: <Middleware<TabState>>[],
          // wrapper: wrapperFunc,
        );

  static Widget wrapperFunc(Widget widget) {
    return KeepAlive(
      child: widget,
      keepAlive: true,
    );
  }
}
