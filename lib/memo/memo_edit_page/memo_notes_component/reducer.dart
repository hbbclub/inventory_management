import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MemoNotesState> buildReducer() {
  return asReducer(
    <Object, Reducer<MemoNotesState>>{
      MemoNotesAction.action: _onAction,
    },
  );
}

MemoNotesState _onAction(MemoNotesState state, Action action) {
  final MemoNotesState newState = state.clone();
  return newState;
}
