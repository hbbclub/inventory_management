import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<WelcomeState> buildReducer() {
  return asReducer(
    <Object, Reducer<WelcomeState>>{
      WelcomeAction.action: _onAction,
    },
  );
}

WelcomeState _onAction(WelcomeState state, Action action) {
  final WelcomeState newState = state.clone();
  return newState;
}
