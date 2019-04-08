import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/printing/std_label_page/std_component/state.dart';

import 'action.dart';
import 'state.dart';

Reducer<StdLabelState> buildReducer() {
  return asReducer(
    <Object, Reducer<StdLabelState>>{
      StdLabelAction.init: _init,
    },
  );
}

//初始化  当前 state
StdLabelState _init(StdLabelState state, Action action) {
  final List<StdState> labels = action.payload ?? <StdState>[];
  final StdLabelState newState = state.clone();
  newState.labels = labels;
  return newState;
}
