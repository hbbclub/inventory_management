import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MemoListTileState> buildReducer() {
  return asReducer(
    <Object, Reducer<MemoListTileState>>{
      // MemoListTileAction.action: _onAction,
    },
  );
}

// MemoListTileState _onAction(MemoListTileState state, Action action) {
//   final MemoListTileState newState = state.clone();
//   return newState;
// }
