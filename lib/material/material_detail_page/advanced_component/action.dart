import 'package:fish_redux/fish_redux.dart';

enum AdvancedAction { action }

class AdvancedActionCreator {
  static Action onAction() {
    return const Action(AdvancedAction.action);
  }
}
