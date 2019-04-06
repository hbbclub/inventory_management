import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MemoSaveState> buildReducer() {
  return asReducer(
    <Object, Reducer<MemoSaveState>>{
      MemoSaveAction.action: _onAction,
    },
  );
}

MemoSaveState _onAction(MemoSaveState state, Action action) {
  final MemoSaveState newState = state.clone();
  return newState;
}
