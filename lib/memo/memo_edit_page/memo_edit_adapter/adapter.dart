import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_edit_page/memo_image_component/component.dart';
import 'package:inventory_management/memo/memo_edit_page/memo_image_component/state.dart';
import 'package:inventory_management/memo/memo_edit_page/state.dart';

import 'reducer.dart';

class MemoEditAdapter extends DynamicFlowAdapter<MemoEditState> {
  MemoEditAdapter()
      : super(
          pool: <String, Component<Object>>{'image': MemoImageComponent()},
          connector: _MemoEditConnector(),
          reducer: buildReducer(),
        );
}

class _MemoEditConnector extends ConnOp<MemoEditState, List<ItemBean>> {
  @override
  List<ItemBean> get(MemoEditState state) {
    if (state.images?.isNotEmpty == true) {
      return state.images
          .map<ItemBean>((MemoImageState data) => ItemBean('image', data))
          .toList(growable: true);
    } else {
      return <ItemBean>[];
    }
  }

  @override
  void set(MemoEditState state, List<ItemBean> items) {
    if (items?.isNotEmpty == true) {
      state.images = List<MemoImageState>.from(
          items.map<MemoImageState>((ItemBean bean) => bean.data).toList());
    } else {
      state.images = <MemoImageState>[];
    }
  }

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
