import 'package:fish_redux/fish_redux.dart';

enum MemoImageAction {
  onRemove,
  remove,
}

class MemoImageActionCreator {
  static Action onRemove(String id) {
    return Action(MemoImageAction.onRemove, payload: id);
  }

  static Action remove(String id) {
    return Action(MemoImageAction.remove, payload: id);
  }
}
