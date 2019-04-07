import 'package:fish_redux/fish_redux.dart';

enum LoginAction { onLogin,changeCanLogin }

class LoginActionCreator {
  static Action onLogin() {
    return Action(LoginAction.onLogin);
  }

  static Action changeCanLogin(bool canLogin) {
    return Action(LoginAction.changeCanLogin,payload: canLogin);
  }
}
