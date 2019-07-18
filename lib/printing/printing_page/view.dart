import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/common/utils.dart';
import 'state.dart';

Widget buildView(
    PrintingState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    resizeToAvoidBottomPadding: false,
    appBar: AppBar(
      title: Text('PRINTING'),
      bottom: new TabBar(
        controller: state.controller,
        tabs: state.choices.map((Choice choice) {
          return Container(
            width: Utils.getScreenWidth(viewService.context) / 2.0,
            child: new Tab(
              text: choice.title,
              icon: new Icon(choice.icon),
            ),
          );
        }).toList(),
      ),
    ),
    body: SafeArea(
      child: TabBarView(
        controller: state.controller,
        children: state.pages,
      ),
    ),
  );
}
