import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/login_page/model/user_model.dart';
import 'package:inventory_management/welcome_page/model/cache_model.dart';

import 'action.dart';
import 'state.dart';

Reducer<InventoryState> buildReducer() {
  return asReducer(
    <Object, Reducer<InventoryState>>{
      InventoryAction.add: _add,
      InventoryAction.subtract: _subtract,
      InventoryAction.scaned: _scaned,
      InventoryAction.init: _init,
      RouteAction.route: _route,
    },
  );
}

InventoryState _route(InventoryState state, Action action) {
  return initState(action.payload);
}

InventoryState _add(InventoryState state, Action action) {
  final InventoryState newState = state.clone();
  newState.qty.text = (int.parse(newState.qty.text) + 1).toString();
  return newState;
}

InventoryState _subtract(InventoryState state, Action action) {
  final InventoryState newState = state.clone();
  if (int.parse(state.qty.text) > 0) {
    newState.qty.text = (int.parse(newState.qty.text) - 1).toString();
  }

  return newState;
}

InventoryState _init(InventoryState state, Action action) {
  InventoryState payload = action.payload;
  final InventoryState newState = state.clone();
  newState.controller = payload.controller;
  newState.cameras = payload.cameras;
  return newState;
}

InventoryState _scaned(InventoryState state, Action action) {
  final InventoryState newState = state.clone();
  Map<String, String> data = action.payload;
  if (data['flag'] == 'TAG') {
    newState.tagNumber.text = data['value'];
  } else if (data['flag'] == 'PART') {
    newState.stockNumber.text = data['value'];
  } else if (data['flag'] == 'LOCT') {
    newState.lotNumber.text = data['value'];
  } else if (data['flag'] == 'LOC') {
    newState.location.text = data['value'];
  }
  return newState;
}
