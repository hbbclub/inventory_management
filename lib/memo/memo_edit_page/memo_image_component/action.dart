import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MemoImageAction { onRemove,
  remove, }

class MemoImageActionCreator {
  static Action onRemove(String id) {
    return Action(MemoImageAction.onRemove, payload: id);
  }

  static Action remove(String id) {
    return Action(MemoImageAction.remove, payload: id);
  }
}
