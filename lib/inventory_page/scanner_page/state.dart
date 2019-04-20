import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/inventory_page/state.dart';
import 'package:inventory_management/route/app_state.dart';

class ScannerState implements Cloneable<ScannerState> {
  List<CameraDescription> cameras;
  TextEditingController tagNumber = TextEditingController();
  TextEditingController stockNumber;
  TextEditingController location;
  TextEditingController lotNumber;
  TextEditingController qty;
  QRReaderController controller;

  bool isfull() {
    return tagNumber.text != '' &&
        stockNumber.text != '' &&
        location.text != '' &&
        lotNumber.text != '' &&
        qty.text != '';
  }

  @override
  ScannerState clone() {
    return ScannerState()
      ..tagNumber = tagNumber
      ..stockNumber = stockNumber
      ..location = location
      ..lotNumber = lotNumber
      ..cameras = cameras
      ..controller = controller
      ..qty = qty;
  }
}

ScannerState initState(InventoryState args) {
  return ScannerState()
    ..tagNumber = args.tagNumber ?? TextEditingController()
    ..stockNumber = args.stockNumber ?? TextEditingController()
    ..location = args.location ?? TextEditingController()
    ..lotNumber = args.lotNumber ?? TextEditingController()
    ..qty = args.qty ?? TextEditingController(text: '0');
}

class ScannerConnector extends ConnOp<AppState, ScannerState> {
  @override
  ScannerState get(AppState appState) {

    final ScannerState state = appState.scannerState.clone();
    return state;
  }

  @override
  void set(AppState appState, ScannerState subState) {

    appState.scannerState = subState.clone();
  }
}
