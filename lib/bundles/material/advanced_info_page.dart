import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/material/Material_Info_tile.dart';
import 'package:inventory_management/bundles/route/route.route.dart';

@ARoute(url: 'router://AdvancedInfoPage')
class AdvancedInfoPage extends StatelessWidget {
  final RouterPageOption initParam;
  AdvancedInfoPage(this.initParam) : super();
  @override
  Widget build(BuildContext context) {
    print(initParam.params);

    return Scaffold(
      appBar: AppBar(
        title: Text('Advanced Info'),
      ),
      body: ListView(
        children: <Widget>[
          MaterialInfoTile(),
          MaterialInfoTile(),
          MaterialInfoTile(),
          MaterialInfoTile(),
          MaterialInfoTile(),
        ],
      ),
    );
  }
}
