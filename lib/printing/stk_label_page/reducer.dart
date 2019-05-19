import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/material/model/material_model.dart';

import 'action.dart';
import 'state.dart';

Reducer<StkLabelState> buildReducer() {
  return asReducer(
    <Object, Reducer<StkLabelState>>{
      StkLabelAction.add: _add,
      StkLabelAction.subtract: _subtract,
      RouteAction.route: _route,
    },
  );
}

StkLabelState _route(StkLabelState state, Action action) {
  final StkLabelState newState = state.clone();
  MaterialModel model = action.payload;

  newState
    ..model = model
    ..stockController = TextEditingController(text: model.partNo)
    ..descController = TextEditingController(text: model.desc)
    ..uomController = TextEditingController(text: model.uom)
    ..qtyController = TextEditingController(text: model.sapQty)
    ..lotNumberController = TextEditingController()
    ..locationController = TextEditingController(text: model.loc);
  newState.items = [
    PrintingStkLabel('Stock Code', '', newState.stockController, false),
    PrintingStkLabel('Description', '', newState.descController, false),
    PrintingStkLabel('UOM', '', newState.uomController, false),
    PrintingStkLabel('QTY', '', newState.qtyController, true),
    PrintingStkLabel('Location', '', newState.locationController, true),
    PrintingStkLabel('Lot Number', '', newState.lotNumberController, true),
  ];
  return newState;
}

StkLabelState _add(StkLabelState state, Action action) {
  final StkLabelState newState = state.clone();

  newState.countController.text =
      (int.parse(newState.countController.text) + 1).toString();
  return newState;
}

StkLabelState _subtract(StkLabelState state, Action action) {
  final StkLabelState newState = state.clone();
  if (int.parse(state.countController.text) > 1) {
    newState.countController.text =
        (int.parse(newState.countController.text) - 1).toString();
  }

  return newState;
}
