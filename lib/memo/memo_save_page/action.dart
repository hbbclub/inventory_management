import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MemoSaveAction { action }

class MemoSaveActionCreator {
  static Action onAction() {
    return const Action(MemoSaveAction.action);
  }
}
