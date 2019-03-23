import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/material/material_Info_tile.dart';
import 'package:inventory_management/bundles/material/material_model.dart';
import 'package:inventory_management/bundles/route/route.route.dart';

@ARoute(url: 'router://AdvancedInfoPage')
class AdvancedInfoPage extends StatelessWidget {
  final RouterPageOption initParam;
  AdvancedInfoPage(this.initParam) : super();
  @override
  Widget build(BuildContext context) {
    print(initParam.params);
    MaterialModel model = initParam.params['model'];
    return Scaffold(
      body: ListView(
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
      ),
    );
  }
}
