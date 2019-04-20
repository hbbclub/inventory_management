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

InventoryState _scaned(InventoryState state, Action action) {
  final InventoryState newState = state.clone();
  scanState.ScannerState sannerResult = action.payload;
  newState
    ..tagNumber = sannerResult.tagNumber
    ..stockNumber = sannerResult.stockNumber
    ..location = sannerResult.location
    ..lotNumber = sannerResult.lotNumber
    ..qty = sannerResult.qty;
  return newState;
}
