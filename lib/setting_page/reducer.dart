import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SettingState> buildReducer() {
  return asReducer(
    <Object, Reducer<SettingState>>{
      RouteAction.route: _route,
    },
  );
}

SettingState _route(SettingState state, Action action) {
  return initState(action.payload).clone();
}
