import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/route/app_state.dart';

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

class PrintingState implements Cloneable<PrintingState> {
  List<Choice> choices = const <Choice>[
    const Choice(
      title: 'STD Label',
      icon: Icons.label,
    ),
    const Choice(title: 'Stk Code Label', icon: Icons.scanner),
  ];
  TabController controller;
  List<Widget> pages = [];
  @override
  PrintingState clone() {
    return PrintingState()
      ..choices = choices
      ..pages = pages
      ..controller = controller;
  }
}

PrintingState initState(Map<String, dynamic> args) {
  return PrintingState();
}

class PrintingConnector extends Reselect<AppState, PrintingState> {
  @override
  void set(AppState appState, PrintingState subState) {
    appState.printingState = subState.clone();
  }

  @override
  PrintingState computed(List list) {
    return list.first;
  }

  @override
  List getSubs(AppState state) {
    return [
      [state.printingState]
    ];
  }
}
