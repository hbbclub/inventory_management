import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/material/material_list_page/page.dart';
import 'package:inventory_management/material/material_list_page/state.dart';
import 'package:inventory_management/printing/printing_page/page.dart';
import 'package:inventory_management/printing/std_label_page/page.dart';
import 'package:inventory_management/route/router.dart';
import 'action.dart';
import 'state.dart';

Effect<PrintingState> buildEffect() {
  return combineEffects(<Object, Effect<PrintingState>>{
    Lifecycle.initState: _onInit,
  });
}

void _onInit(Action action, Context<PrintingState> ctx) {
  final TickerProvider tickerProvider = ctx.stfState as TickerComponentState;
  PrintingState state = PrintingState();
  state.controller = TabController(length: 2, vsync: tickerProvider);

  state.pages = [
    appRouter.buildPage(routerNameForStdLabelPage),
    appRouter.buildPage(routerNameForMaterialListPage,
        arguments: {'type': MaterialListType.component}),
  ];
  ctx.dispatch(PrintingActionCreator.init(state));
}
