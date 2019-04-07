import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MemoImageState> buildReducer() {
  return asReducer(
    <Object, Reducer<MemoImageState>>{
      // MemoImageAction.action: _onAction,
    },
  );
}

// MemoImageState _onAction(MemoImageState state, Action action) {
//   final MemoImageState newState = state.clone();
//   return newState;
// }
