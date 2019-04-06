import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/state.dart';

enum MemoPageAction {  init }

class MemoPageActionCreator {
  static Action init(List<MemoListTileState> list) {
    return Action(MemoPageAction.init, payload: list);
  }
}
