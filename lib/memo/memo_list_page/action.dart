import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/state.dart';

enum MemoPageAction { init ,onSearch,clearSearch,onLoadmore}

class MemoPageActionCreator {
  static Action init(List<MemoListTileState> list) {
    return Action(MemoPageAction.init, payload: list);
  }
  static Action onSearch(String keyword) {
    return Action(MemoPageAction.onSearch, payload: keyword);
  }
  static Action onLoadmore(int current) {
    return Action(MemoPageAction.onLoadmore, payload: current);
  }
  static Action clearSearch() {
    return Action(MemoPageAction.clearSearch);
  }
}
