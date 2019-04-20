import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/login_page/state.dart';
import 'package:inventory_management/welcome_page/state.dart';

class AppState implements Cloneable<AppState> {
  WelcomeState welcomeState = WelcomeState();
  LoginState loginState = LoginState();

  @override
  AppState clone() {
    return AppState()
    ..welcomeState = welcomeState.clone()
    ..loginState = loginState.clone()
    ;
  }
}
