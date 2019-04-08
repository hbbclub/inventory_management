import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/state.dart';

import 'action.dart';
import 'state.dart';

Reducer<MemoListState> buildReducer() {
  return asReducer(
    <Object, Reducer<MemoListState>>{
      MemoPageAction.init: _init,
    },
  );
}

MemoListState _init(MemoListState state, Action action) {
  final List<MemoListTileState> list = action.payload ?? <MemoListTileState>[];
  final MemoListState newState = state.clone();
  newState.list = list;
  return newState;
}
