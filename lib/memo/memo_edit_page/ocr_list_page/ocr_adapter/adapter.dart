import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_edit_page/ocr_list_page/ocr_label_component/component.dart';
import 'package:inventory_management/memo/memo_edit_page/ocr_list_page/ocr_label_component/state.dart';
import 'package:inventory_management/memo/memo_edit_page/ocr_list_page/state.dart';

import 'reducer.dart';

class OcrAdapter extends DynamicFlowAdapter<OcrListState> {
  OcrAdapter()
      : super(
          pool: <String, Component<Object>>{'ocr': OcrLabelComponent()},
          connector: _OcrConnector(),
          reducer: buildReducer(),
        );
}

class _OcrConnector extends ConnOp<OcrListState, List<ItemBean>> {
  @override
  List<ItemBean> get(OcrListState state) {
    if (state.currentTextLabels?.isNotEmpty == true) {
      return state.currentTextLabels
          .map<ItemBean>((OcrLabelState data) => ItemBean('ocr', data))
          .toList(growable: true);
    } else {
      return <ItemBean>[];
    }
  }

  @override
  void set(OcrListState state, List<ItemBean> items) {
    if (items?.isNotEmpty == true) {
      state.currentTextLabels = List<OcrLabelState>.from(
          items.map<OcrLabelState>((ItemBean bean) => bean.data).toList());
    } else {
      state.currentTextLabels = <OcrLabelState>[];
    }
  }

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
