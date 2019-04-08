import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/setting_page/page.dart';
import 'package:inventory_management/tab_page/page.dart';
import 'package:inventory_management/main_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<TabState> buildEffect() {
  return combineEffects(<Object, Effect<TabState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _dispose,
    TabAction.onIndexChanged: _onIndexChanged,
  });
}

void _dispose(Action action, Context<TabState> ctx) {
  for (NavigationIconView view in ctx.state.navigationViews)
    view.controller.dispose();
}

_onIndexChanged(Action action, Context<TabState> ctx) {
  int index = action.payload;
  ctx.state.controller.jumpToPage(index);
  ctx.state.navigationViews[ctx.state.currentIndex].controller.reverse();
  ctx.dispatch(TabActionCreator.indexChanged(index));
  ctx.state.navigationViews[ctx.state.currentIndex].controller.forward();
}

void _onInit(Action action, Context<TabState> ctx) {
  final TickerProvider tickerProvider = ctx.stfState as TickerComponentState;
  TabState state = TabState();
  state.controller = new PageController(initialPage: 0);
  state.navigationViews = <NavigationIconView>[
    NavigationIconView(
      icon: Icon(Icons.home),
      title: 'HOME',
      color: Colors.teal,
      vsync: tickerProvider,
    ),
    NavigationIconView(
      icon: Icon(Icons.settings),
      title: 'SETTING',
      color: Colors.pink,
      vsync: tickerProvider,
    )
  ];
  state.pages = [
    MainPage(null).buildPage({}),
    SettingPage(null).buildPage({}),
  ];
  ctx.dispatch(TabActionCreator.init(state));
}
