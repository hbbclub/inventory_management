import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<OcrLabelState> buildReducer() {
  return asReducer(
    <Object, Reducer<OcrLabelState>>{
      OcrLabelAction.check: _check,
    },
  );
}

OcrLabelState _check(OcrLabelState state, Action action) {
  final OcrLabelState newState = state.clone();
  newState.selected = !newState.selected;
  return newState;
}
