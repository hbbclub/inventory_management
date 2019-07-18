import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<WelcomeState> buildReducer() {
  return asReducer(
    <Object, Reducer<WelcomeState>>{
      WelcomeAction.action: _onAction,
      RouteAction.route: _route,
    },
  );
}

WelcomeState _route(WelcomeState state, Action action) {
  final WelcomeState newState = state.clone();
  return newState;
}

WelcomeState _onAction(WelcomeState state, Action action) {
  final WelcomeState newState = state.clone();
  return newState;
}
