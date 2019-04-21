import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SettingState> buildReducer() {
  return asReducer(
    <Object, Reducer<SettingState>>{
      RouteAction.route: _route,
      SettingAction.updateBlueTooth: _updateBlueTooth,
      SettingAction.updateFlag: _updateFlag,
      SettingAction.updateActivity: _updateActivity,
    },
  );
}

SettingState _route(SettingState state, Action action) {
  return initState(action.payload).clone();
}

SettingState _updateBlueTooth(SettingState state, Action action) {
  final SettingState newState = state.clone();
  newState.blueToothList = action.payload;
  return newState;
}

SettingState _updateFlag(SettingState state, Action action) {
  final SettingState newState = state.clone();
  newState.flag = action.payload;
  return newState;
}
SettingState _updateActivity(SettingState state, Action action) {
  final SettingState newState = state.clone();
  newState.activity = action.payload;
  return newState;
}
