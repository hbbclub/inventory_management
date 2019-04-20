import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/route/app_state.dart';

class WelcomeState implements Cloneable<WelcomeState> {

  @override
  WelcomeState clone() {
    return WelcomeState();
  }
}

WelcomeState initState(Map<String, dynamic> args) {
  return WelcomeState();
}

class WelcomeConnector extends ConnOp<AppState, WelcomeState> {
  @override
  WelcomeState get(AppState appState) {
    final WelcomeState state =  appState.welcomeState.clone();
    return state;
  }

  @override
  void set(AppState appState, WelcomeState subState) {
    appState.welcomeState = subState.clone();
  }
}
