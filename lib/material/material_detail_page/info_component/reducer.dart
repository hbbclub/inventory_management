import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<InfoState> buildReducer() {
  return asReducer(
    <Object, Reducer<InfoState>>{
      InfoAction.action: _onAction,
    },
  );
}

InfoState _onAction(InfoState state, Action action) {
  final InfoState newState = state.clone();
  return newState;
}
