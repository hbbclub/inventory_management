import 'package:fish_redux/fish_redux.dart';

class WelcomeState implements Cloneable<WelcomeState> {

  @override
  WelcomeState clone() {
    return WelcomeState();
  }
}

WelcomeState initState(Map<String, dynamic> args) {
  return WelcomeState();
}
