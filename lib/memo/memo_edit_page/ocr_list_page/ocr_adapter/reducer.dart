import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_edit_page/ocr_list_page/ocr_label_component/action.dart';
import 'package:inventory_management/memo/memo_edit_page/ocr_list_page/ocr_label_component/state.dart';
import 'package:inventory_management/memo/memo_edit_page/ocr_list_page/state.dart';

import 'action.dart';

Reducer<OcrListState> buildReducer() {
  return asReducer(
    <Object, Reducer<OcrListState>>{
      OcrLabelAction.check: _check,
    },
  );
}

OcrListState _check(OcrListState state, Action action) {
  final OcrListState newState = state.clone();
  final String id = action.payload;
  OcrLabelState checkState = newState.currentTextLabels
      .firstWhere((OcrLabelState state) => state.id == id);
  checkState.selected = !checkState.selected;
  return newState;
}
