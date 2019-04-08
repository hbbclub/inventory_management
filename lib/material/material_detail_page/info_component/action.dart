import 'package:fish_redux/fish_redux.dart';

enum InfoAction { action }

class InfoActionCreator {
  static Action onAction() {
    return const Action(InfoAction.action);
  }
}
