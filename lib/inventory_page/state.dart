import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/common/player.dart';
import 'package:inventory_management/route/app_state.dart';

class InventoryState implements Cloneable<InventoryState> {
  TextEditingController tagNumber = TextEditingController();
  TextEditingController stockNumber = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController lotNumber = TextEditingController();
  TextEditingController qty = TextEditingController(text: '0');
  List<CameraDescription> cameras;
  QRReaderController controller;
  Player player = Player();

  @override
  InventoryState clone() {
    return InventoryState()
      ..tagNumber = tagNumber
      ..stockNumber = stockNumber
      ..location = location
      ..lotNumber = lotNumber
      ..controller = controller
      ..cameras = cameras
      ..player = player
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
