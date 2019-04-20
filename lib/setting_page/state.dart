import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/route/app_state.dart';

class SettingState implements Cloneable<SettingState> {

  @override
  SettingState clone() {
    return SettingState();
  }
}

SettingState initState(Map<String, dynamic> args) {
  return SettingState();
}

class SettingConnector extends ConnOp<AppState, SettingState> {
  @override
  SettingState get(AppState appState) {
    final SettingState state = appState.settingState.clone();
    return state;
  }

  @override
  void set(AppState appState, SettingState subState) {

    appState.settingState = subState.clone();
  }
}