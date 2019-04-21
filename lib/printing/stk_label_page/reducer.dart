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
    ..lotNumberController = TextEditingController(text: model.loc)
    ..locationController = TextEditingController(text: model.loc);
  newState.items = [
    PrintingStkLabel('Stock Code', '', newState.stockController),
    PrintingStkLabel('Description', '', newState.descController),
    PrintingStkLabel('UOM', '', newState.uomController),
    PrintingStkLabel('QTY', '', newState.qtyController),
    PrintingStkLabel('Lot Number', '', newState.lotNumberController),
    PrintingStkLabel('Location', '', newState.locationController),
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
