import 'package:fish_redux/fish_redux.dart';

enum MemoNotesAction { action }

class MemoNotesActionCreator {
  static Action onAction() {
    return const Action(MemoNotesAction.action);
  }
}
