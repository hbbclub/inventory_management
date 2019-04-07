import 'package:fish_redux/fish_redux.dart';

enum MemoListAction { action }

class MemoListActionCreator {
  static Action onAction() {
    return const Action(MemoListAction.action);
  }
}
