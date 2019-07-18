import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/route/app_state.dart';

class ResetPasswordState implements Cloneable<ResetPasswordState> {

  @override
  ResetPasswordState clone() {
    return ResetPasswordState();
  }
}

ResetPasswordState initState(Map<String, dynamic> args) {
  return ResetPasswordState();
}

class ResetPasswordConnector extends ConnOp<AppState, ResetPasswordState> {
  @override
  ResetPasswordState get(AppState appState) {
    final ResetPasswordState state = appState.resetPasswordState.clone();
    return state;
  }

  @override
  void set(AppState appState, ResetPasswordState subState) {

    appState.resetPasswordState = subState.clone();
  }
}