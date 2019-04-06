import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MemoListAction { action }

class MemoListActionCreator {
  static Action onAction() {
    return const Action(MemoListAction.action);
  }
}
