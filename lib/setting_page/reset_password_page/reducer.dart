import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ResetPasswordState> buildReducer() {
  return asReducer(
    <Object, Reducer<ResetPasswordState>>{
      RouteAction.route: _route,
    },
  );
}

ResetPasswordState _route(ResetPasswordState state, Action action) {
  return initState(action.payload).clone();
}
