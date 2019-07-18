import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/state.dart'
    as listState;

import 'action.dart';
import 'state.dart';

Reducer<MemoListState> buildReducer() {
  return asReducer(
    <Object, Reducer<MemoListState>>{
      MemoPageAction.init: _init,
      RouteAction.route: _route,
      MemoPageAction.clearSearch: _clearSearch,
    },
  );
}

MemoListState _route(MemoListState state, Action action) {
  return initState(action.payload).clone();
}

MemoListState _clearSearch(MemoListState state, Action action) {
  final MemoListState newState = state.clone();
  newState.keywordController.text = '';
  return newState;
}

MemoListState _init(MemoListState state, Action action) {
  final List<listState.MemoListTileState> list =
      action.payload ?? <listState.MemoListTileState>[];
  final MemoListState newState = state.clone();
  newState.list = list;
  return newState;
}
