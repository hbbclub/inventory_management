import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_edit_page/ocr_list_page/ocr_label_component/state.dart'
    as labelState;

import 'action.dart';
import 'state.dart';

Reducer<OcrListState> buildReducer() {
  return asReducer(
    <Object, Reducer<OcrListState>>{
      OcrListAction.init: _init,
      RouteAction.route: _route,
    },
  );
}

OcrListState _route(OcrListState state, Action action) {
  return initState(action.payload).clone();
}

OcrListState _init(OcrListState state, Action action) {
  final OcrListState newState = state.clone();
  List<labelState.OcrLabelState> labels = action.payload;
  newState.currentTextLabels = labels;
  return newState;
}
