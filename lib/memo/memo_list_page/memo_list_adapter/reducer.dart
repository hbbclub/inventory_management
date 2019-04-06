import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/action.dart'
    as listTileAction;
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/state.dart';
import 'package:inventory_management/memo/memo_list_page/state.dart';

import 'action.dart';

Reducer<MemoListState> buildReducer() {
  return asReducer(
    <Object, Reducer<MemoListState>>{
      listTileAction.MemoListTileAction.remove: _remove,
    },
  );
}

MemoListState _remove(MemoListState state, Action action) {
  final MemoListState newState = state.clone();
  final String id = action.payload;
  newState.list.removeWhere((MemoListTileState state) => state.id == id);
  return newState;
}
