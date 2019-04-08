import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/state.dart';

enum MemoListTileAction { onRemove, remove, onEdit }

class MemoListTileActionCreator {
  static Action onRemove(String id) {
    return Action(MemoListTileAction.onRemove, payload: id);
  }

  static Action remove(String id) {
    return Action(MemoListTileAction.remove, payload: id);
  }

  static Action onEdit(MemoListTileState state) {
    return Action(MemoListTileAction.onEdit, payload: state);
  }
}
