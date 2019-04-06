import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/state.dart';

class MemoListState implements Cloneable<MemoListState> {
  List<MemoListTileState> list = [];
  @override
  MemoListState clone() {
    return MemoListState()..list = list;
  }
}

MemoListState initState(Map<String, dynamic> args) {
  return MemoListState();
}
