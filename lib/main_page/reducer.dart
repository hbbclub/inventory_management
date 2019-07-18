import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MainState> buildReducer() {
  return asReducer(
    <Object, Reducer<MainState>>{
        RouteAction.route: _route,
    },
  );
}

MainState _route(MainState state, Action action) {
  return initState(action.payload).clone();
}
