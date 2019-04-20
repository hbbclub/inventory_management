import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<LoginState> buildReducer() {
  return asReducer(
    <Object, Reducer<LoginState>>{
    
      LoginAction.changeCanLogin: _changeCanLogin,
      RouteAction.route: _route,
    },
  );
}

LoginState _route(LoginState state, Action action) {
  return initState(action.payload).clone();
}

LoginState _changeCanLogin(LoginState state, Action action) {
  bool canLogin = action.payload;
  final LoginState newState = state.clone();
  newState.canDoLogin = canLogin;
  return newState;
}
