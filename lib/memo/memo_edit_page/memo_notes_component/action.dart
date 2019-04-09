import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MemoNotesAction { action }

class MemoNotesActionCreator {
  static Action onAction() {
    return const Action(MemoNotesAction.action);
  }
}
