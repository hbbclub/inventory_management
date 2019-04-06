import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/printing/std_label_page/state.dart';
import 'package:inventory_management/printing/std_label_page/std_component/component.dart';
import 'package:inventory_management/printing/std_label_page/std_component/state.dart';

import 'reducer.dart';

class StdAdapter extends DynamicFlowAdapter<StdLabelState> {
  StdAdapter()
      : super(
          pool: <String, Component<Object>>{'stdLabel': StdComponent()},
          connector: _StdConnector(),
          reducer: buildReducer(),
        );
}

class _StdConnector extends ConnOp<StdLabelState, List<ItemBean>> {
  @override
  List<ItemBean> get(StdLabelState state) {
    if (state.labels?.isNotEmpty == true) {
      return state.labels
          .map<ItemBean>((StdState data) => ItemBean('stdLabel', data))
          .toList(growable: true);
    } else {
      return <ItemBean>[];
    }
  }

  @override
  void set(StdLabelState state, List<ItemBean> items) {
    if (items?.isNotEmpty == true) {
      state.labels = List<StdState>.from(
          items.map<StdState>((ItemBean bean) => bean.data).toList());
    } else {
      state.labels = <StdState>[];
    }
  }

  @override
  subReducer(reducer) {
    return super.subReducer(reducer);
  }
}
