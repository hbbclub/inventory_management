import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/state.dart';
import 'package:inventory_management/route/app_state.dart';

class MemoListState implements Cloneable<MemoListState> {
  List<MemoListTileState> list = [];
  TextEditingController keywordController = TextEditingController();
  @override
  MemoListState clone() {
    return MemoListState()
      ..list = list
      ..keywordController = keywordController;
  }
}

MemoListState initState(Map<String, dynamic> args) {
  return MemoListState();
}


class MemoListConnector extends ConnOp<AppState, MemoListState> {
  @override
  MemoListState get(AppState appState) {
    final MemoListState state = appState.memoListState.clone();
    return state;
  }

  @override
  void set(AppState appState, MemoListState subState) {

    appState.memoListState = subState.clone();
  }
}