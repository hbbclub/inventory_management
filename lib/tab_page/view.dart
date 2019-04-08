import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(TabState state, Dispatch dispatch, ViewService viewService) {
  final BottomNavigationBar botNavBar = BottomNavigationBar(
    items: state.navigationViews
        .map((NavigationIconView navigationView) => navigationView.item)
        .toList(),
    currentIndex: state.currentIndex,
    type: state.type,
    onTap: (int index) =>dispatch(TabActionCreator.onIndexChanged(index)),
  );

  return Scaffold(
    resizeToAvoidBottomPadding: false,
    body: new PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: state.controller,
      children: state.pages,
    ),
    bottomNavigationBar: botNavBar,
  );
}
