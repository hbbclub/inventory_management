import 'package:flutter/material.dart';
import 'package:inventory_management/material/material_Info_tile.dart';
import 'package:inventory_management/material/material_model.dart';

class Info extends StatelessWidget {
  final MaterialModel model;
  Info(this.model);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 16,
        ),
        MaterialInfoTile('Stock Code', model.partNo ?? ''),
        MaterialInfoTile('Description', model.desc ?? ''),
        MaterialInfoTile('UOM', model.uom ?? ''),
        MaterialInfoTile('Unit Cost', (model.unitCost ?? 0).toString()),
        MaterialInfoTile('Default Location', model.loc ?? ''),
        MaterialInfoTile('QTY', (model.sapQty ?? 0).toString()),
        MaterialInfoTile('Tech Spec', '技术规范'),
      ],
    );
  }
}
