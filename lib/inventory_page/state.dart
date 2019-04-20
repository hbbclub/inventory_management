import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/route/app_state.dart';

class InventoryState implements Cloneable<InventoryState> {
  TextEditingController tagNumber = TextEditingController();
  TextEditingController stockNumber = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController lotNumber = TextEditingController();
  TextEditingController qty = TextEditingController(text: '0');

  @override
  InventoryState clone() {
    return InventoryState()
      ..tagNumber = tagNumber
      ..stockNumber = stockNumber
      ..location = location
      ..lotNumber = lotNumber
      ..qty = qty;
  }
}

InventoryState initState(Map<String, dynamic> args) {
  return InventoryState();
}


class InventoryConnector extends ConnOp<AppState, InventoryState> {
  @override
  InventoryState get(AppState appState) {

    final InventoryState state = appState.inventoryState.clone();
    return state;
  }

  @override
  void set(AppState appState, InventoryState subState) {

    appState.inventoryState = subState.clone();
  }
}
