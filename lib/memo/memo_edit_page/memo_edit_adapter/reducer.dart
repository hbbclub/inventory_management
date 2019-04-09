import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_edit_page/memo_image_component/action.dart';
import 'package:inventory_management/memo/memo_edit_page/memo_image_component/state.dart';
import 'package:inventory_management/memo/memo_edit_page/state.dart';

import 'action.dart';

Reducer<MemoEditState> buildReducer() {
  return asReducer(
    <Object, Reducer<MemoEditState>>{
      MemoImageAction.remove: _remove,
      MemoEditAction.loadAssets: _loadAssets,
    },
  );
}

MemoEditState _remove(MemoEditState state, Action action) {
  final MemoEditState newState = state.clone();
  final String id = action.payload;
  newState.images
      .removeWhere((item) => (item is MemoImageState) && (item.id == id));
  return newState;
}

MemoEditState _loadAssets(MemoEditState state, Action action) {
  final MemoEditState newState = state.clone();
  List<MemoImageState> resultList = action.payload;
  newState.images.addAll(resultList);
  return newState;
}
