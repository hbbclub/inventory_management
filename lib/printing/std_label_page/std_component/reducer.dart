import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<StdState> buildReducer() {
  return asReducer(
    <Object, Reducer<StdState>>{
      StdAction.add: _add,
      StdAction.subtract: _subtract,
    },
  );
}

StdState _add(StdState state, Action action) {
  final StdState newState = state.clone();
  newState.textController.text =
      (int.parse(newState.textController.text) + 1).toString();

  return newState;
}

StdState _subtract(StdState state, Action action) {
  final StdState newState = state.clone();
  if (int.parse(state.textController.text) > 0) {
    newState.textController.text =
        (int.parse(newState.textController.text) - 1).toString();
  }
  return newState;
}
