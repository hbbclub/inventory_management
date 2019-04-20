import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TickerComponentState extends ComponentState<TabState>
    with TickerProviderStateMixin {}

const routerNameForTabPage = 'router://TabPage';

class TabPage extends Page<TabState, Map<String, dynamic>> {
  @override
  TickerComponentState createState() => TickerComponentState();

  TabPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TabState>(
              adapter: null, slots: <String, Dependent<TabState>>{}),
          middleware: <Middleware<TabState>>[],
        );
}
