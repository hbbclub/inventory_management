import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MemoEditState> buildReducer() {
  return asReducer(
    <Object, Reducer<MemoEditState>>{
      MemoEditPageAction.didOcr: _didOcr,
    },
  );
}

MemoEditState _didOcr(MemoEditState state, Action action) {
  MemoEditState newState = state.clone();
  newState.textEditingController.text =
      newState.textEditingController.text + action.payload;
  return newState;
}
