import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/common/keep_alive_widget.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

const routerNameForSettingPage = 'router://SettingPage';

class SettingPage extends Page<SettingState, Map<String, dynamic>> {
  SettingPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SettingState>(
              adapter: null, slots: <String, Dependent<SettingState>>{}),
          middleware: <Middleware<SettingState>>[],
          wrapper: wrapperFunc,
        );

  static Widget wrapperFunc(Widget widget) {
    return KeepAliveWidget(widget);
  }
}
