import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MaterialListState> buildReducer() {
  return asReducer(
    <Object, Reducer<MaterialListState>>{
      MaterialListAction.action: _onAction,
    },
  );
}

MaterialListState _onAction(MaterialListState state, Action action) {
  final MaterialListState newState = state.clone();
  return newState;
}
