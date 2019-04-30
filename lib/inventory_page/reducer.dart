import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/inventory_page/scanner_page/state.dart'
    as scanState;

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
  InventoryState payload =action.payload;
  final InventoryState newState = state.clone();
  newState.controller = payload.controller;
  newState.cameras = payload.cameras;
  return newState;
}

InventoryState _scaned(InventoryState state, Action action) {
  String code = action.payload;
  final InventoryState newState = state.clone();
  if (RegExp(r"^[T].*").matchAsPrefix(code) != null) {
    newState.tagNumber.text = code.substring(1);
  } else if (RegExp(r"^[S].*").matchAsPrefix(code) != null) {
    newState.stockNumber.text = code.substring(1);
  } else if (RegExp(r"^[Q].*").matchAsPrefix(code) != null) {
    newState.qty.text = code.substring(1);
  } else if (RegExp(r"^[N].*").matchAsPrefix(code) != null) {
    newState.lotNumber.text = code.substring(1);
  } else if (RegExp(r"^[L].*").matchAsPrefix(code) != null) {
    newState.location.text = code.substring(1);
  }
  return newState;
}
