import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/route/app_state.dart';
import 'package:inventory_management/setting_page/model/blue_tooth_model.dart';
import 'package:json_annotation/json_annotation.dart';

class SettingState implements Cloneable<SettingState> {
  String activity;
  String flag = '';
  List<BlueToothModel> blueToothList = [];
  @override
  SettingState clone() {
    return SettingState()
      ..activity = activity
      ..blueToothList = blueToothList
      ..flag = flag;
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
