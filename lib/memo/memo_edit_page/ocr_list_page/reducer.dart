import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_edit_page/ocr_list_page/ocr_label_component/state.dart';

import 'action.dart';
import 'state.dart';

Reducer<OcrListState> buildReducer() {
  return asReducer(
    <Object, Reducer<OcrListState>>{
      OcrListAction.init: _init,
      
    },
  );
}

OcrListState _init(OcrListState state, Action action) {
  final OcrListState newState = state.clone();
  List<OcrLabelState> labels = action.payload;
  newState.currentTextLabels = labels;
  return newState;
}
