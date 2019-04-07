import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AdvancedState> buildReducer() {
  return asReducer(
    <Object, Reducer<AdvancedState>>{
      AdvancedAction.action: _onAction,
    },
  );
}

AdvancedState _onAction(AdvancedState state, Action action) {
  final AdvancedState newState = state.clone();
  return newState;
}
