import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/material/model/material_model.dart';
import 'package:inventory_management/route/app_state.dart';

class StkLabelState implements Cloneable<StkLabelState> {
  List<PrintingStkLabel> items;
  MaterialModel model;
  TextEditingController stockController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController uomController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController lotNumberController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  TextEditingController countController = TextEditingController(text: '1');

  @override
  StkLabelState clone() {
    return StkLabelState()
      ..items = items
      ..stockController = stockController
      ..descController = descController
      ..uomController = uomController
      ..qtyController = qtyController
      ..lotNumberController = lotNumberController
      ..locationController = locationController
      ..countController = countController
      ..model = model;
  }
}

StkLabelState initState(Map<String, dynamic> args) {
  StkLabelState state = StkLabelState();

  return state;
}

class PrintingStkLabel {
  String title;
  String initValue;
  TextEditingController controller;
  PrintingStkLabel(this.title, this.initValue, this.controller);
}

class StkLabelConnector extends ConnOp<AppState, StkLabelState> {
  @override
  StkLabelState get(AppState appState) {
    final StkLabelState state = appState.stkLabelState.clone();
    return state;
  }

  @override
  void set(AppState appState, StkLabelState subState) {
    appState.stkLabelState = subState.clone();
  }
}
