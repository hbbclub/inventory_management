import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/material/model/material_model.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(StockState state, Dispatch dispatch, ViewService viewService) {
  List<Widget> widgets = state.model.list.map<Widget>((StockTileModel model) {
        return MaterialStockTile(model.title, model.label);
      }).toList() ??
      [];
  widgets.insertAll(0, [
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
  ]);
  return ListView(
    children: widgets,
  );
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
