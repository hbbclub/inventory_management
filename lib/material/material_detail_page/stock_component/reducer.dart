import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<StockState> buildReducer() {
  return asReducer(
    <Object, Reducer<StockState>>{
      StockAction.init: _init,
    },
  );
}

StockState _init(StockState state, Action action) {
  final StockState newState = state.clone();
  newState.model.list = action.payload;
  return newState;
}
