import 'package:fish_redux/fish_redux.dart';

class ResetPasswordState implements Cloneable<ResetPasswordState> {

  @override
  ResetPasswordState clone() {
    return ResetPasswordState();
  }
}

ResetPasswordState initState(Map<String, dynamic> args) {
  return ResetPasswordState();
}
