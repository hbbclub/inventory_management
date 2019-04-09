import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/material/components/material_Info_tile.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    AdvancedState state, Dispatch dispatch, ViewService viewService) {
  return ListView(
    children: <Widget>[
      SizedBox(
        height: 16,
      ),
      MaterialInfoTile('Stock Code', state.model.partNo ?? ''),
      MaterialInfoTile('Description', state.model.desc ?? ''),
      MaterialInfoTile('UOM', state.model.uom ?? ''),
      MaterialInfoTile('Unit Cost', (state.model.unitCost ?? 0).toString()),
      MaterialInfoTile('Default Location', state.model.loc ?? ''),
      MaterialInfoTile('QTY', (state.model.sapQty ?? 0).toString()),
      MaterialInfoTile('Tech Spec', state.model.techSpec),
    ],
  );
}
