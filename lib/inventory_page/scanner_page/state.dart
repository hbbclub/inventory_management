import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/inventory_page/state.dart';

class ScannerState implements Cloneable<ScannerState> {
  List<CameraDescription> cameras;
  TextEditingController tagNumber;
  TextEditingController stockNumber;
  TextEditingController location;
  TextEditingController lotNumber;
  TextEditingController qty = TextEditingController(text: '0');
  QRReaderController controller;

  bool isfull() {
    return tagNumber.text != null &&
        stockNumber.text != null &&
        location.text != null &&
        lotNumber.text != null &&
        qty.text != null;
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
    ..tagNumber = args.tagNumber
    ..stockNumber = args.stockNumber
    ..location = args.location
    ..lotNumber = args.lotNumber
    ..qty = args.qty;
}
