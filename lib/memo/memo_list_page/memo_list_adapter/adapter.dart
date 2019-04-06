import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/component.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/state.dart';
import 'package:inventory_management/memo/memo_list_page/state.dart';

import 'reducer.dart';

class MemoListAdapter extends DynamicFlowAdapter<MemoListState> {
  MemoListAdapter()
      : super(
          pool: <String, Component<Object>>{
            'memoListTile': MemoListTileComponent()
          },
          connector: _MemoListConnector(),
          reducer: buildReducer(),
        );
}

class _MemoListConnector extends ConnOp<MemoListState, List<ItemBean>> {
  @override
  List<ItemBean> get(MemoListState state) {
    if (state.list?.isNotEmpty == true) {
      return state.list
          .map<ItemBean>((MemoListTileState data) => ItemBean('memoListTile', data))
          .toList(growable: true);
    } else {
      return <ItemBean>[];
    }
  }

  @override
  void set(MemoListState state, List<ItemBean> items) {
    if (items?.isNotEmpty == true) {
      state.list = List<MemoListTileState>.from(
          items.map<MemoListTileState>((ItemBean bean) => bean.data).toList());
    } else {
      state.list = <MemoListTileState>[];
    }
  }

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
