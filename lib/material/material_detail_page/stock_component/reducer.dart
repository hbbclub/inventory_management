import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<StockState> buildReducer() {
  return asReducer(
    <Object, Reducer<StockState>>{
      StockAction.action: _onAction,
    },
  );
}

StockState _onAction(StockState state, Action action) {
  final StockState newState = state.clone();
  return newState;
}
