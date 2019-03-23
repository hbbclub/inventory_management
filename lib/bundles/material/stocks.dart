import 'package:annotation_route/route.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/material/material_model.dart';
import 'package:inventory_management/bundles/route/route.route.dart';

@ARoute(url: 'router://AdvancedStockInfo')
class AdvancedStockPage extends StatelessWidget {
  final RouterPageOption initParam;
  AdvancedStockPage(this.initParam) : super();
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
          Container(
            alignment: Alignment.centerLeft,
            height: 40.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    'LOC',
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'QTY',
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          ),
          MaterialStockTile('loc1', '11111'),
          MaterialStockTile('loc1', '222'),
          MaterialStockTile('loc1', '333'),
        ],
      ),
    );
  }
}

class MaterialStockTile extends StatelessWidget {
  final String title;
  final String subtext;
  MaterialStockTile(this.title, this.subtext);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 40.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(color: Color(0XFF999999)),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              subtext,
              textAlign: TextAlign.left,
              style: TextStyle(color: Color(0XFF999999)),
            ),
          )
        ],
      ),
    );
  }
}
