import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<StkLabelState> buildReducer() {
  return asReducer(
    <Object, Reducer<StkLabelState>>{
      StkLabelAction.add: _add,
      StkLabelAction.subtract :_subtract,
    },
  );
}

StkLabelState _add(StkLabelState state, Action action) {
  final StkLabelState newState = state.clone();
  newState.countController.text = (int.parse(newState.countController.text) + 1).toString();
  return newState;
}

StkLabelState _subtract(StkLabelState state, Action action) {
  final StkLabelState newState = state.clone();
  if (int.parse(state.countController.text) > 0) {
    newState.countController.text = (int.parse(newState.countController.text) - 1).toString();
  }

  return newState;
}