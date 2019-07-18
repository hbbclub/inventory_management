import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/common/keep_alive_widget.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TickerComponentState extends ComponentState<PrintingState>
    with TickerProviderStateMixin {}

const routerNameForPrintingPage = 'router://PrintingPage';

class PrintingPage extends Page<PrintingState, Map<String, dynamic>> {
  @override
  TickerComponentState createState() => TickerComponentState();

  PrintingPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PrintingState>(
              adapter: null, slots: <String, Dependent<PrintingState>>{}),
          middleware: <Middleware<PrintingState>>[],
          wrapper: wrapperFunc,
        );

  static Widget wrapperFunc(Widget widget) {
    return KeepAliveWidget(
      widget,
    );
  }
}
