import 'package:fish_redux/fish_redux.dart';

enum LoginAction { onLogin,changeCanLogin,loading }

class LoginActionCreator {
  static Action onLogin() {
    return Action(LoginAction.onLogin);
  }

  static Action changeCanLogin(bool canLogin) {
    return Action(LoginAction.changeCanLogin,payload: canLogin);
  }
  static Action loading(bool loading) {
    return Action(LoginAction.loading,payload: loading);
  }
}
