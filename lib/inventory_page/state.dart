import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

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
