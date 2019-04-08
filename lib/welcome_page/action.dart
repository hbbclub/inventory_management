import 'package:fish_redux/fish_redux.dart';

enum WelcomeAction { action }

class WelcomeActionCreator {
  static Action onAction() {
    return const Action(WelcomeAction.action);
  }
}
