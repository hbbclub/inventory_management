import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/bundles/bloc/bloc_provider.dart';
import 'package:inventory_management/bundles/common/images.dart';
import 'package:inventory_management/bundles/common/utils.dart';
import 'package:inventory_management/bundles/material/material_Info_tile.dart';
import 'package:inventory_management/bundles/material/material_model.dart';
import 'package:inventory_management/bundles/material/search_material.dart';
import 'package:inventory_management/bundles/route/route.route.dart';

class MaterialInfoPage extends StatefulWidget {
  @override
  MaterialInfoPageState createState() {
    return new MaterialInfoPageState();
  }
}

class MaterialInfoPageState extends State<MaterialInfoPage> {
  TextEditingController controller;
  MaterialModel model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController.fromValue(TextEditingValue.empty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            color: Colors.blue,
            padding: EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 10,
            ),
            child: Container(
              child: InkWell(
                onTap: () async{
                  MaterialBloc materialBloc = BlocProvider.of<MaterialBloc>(context);
                 await showSearch(
                    delegate: SearchMaterial<MaterialBloc>(materialBloc),
                    context: context,
                  );
                 
                },
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.barcode),
              onPressed: () async {},
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Image.asset(ImageAssets.materalIcon),
              MaterialInfoTile('Stock Code', '部门编号'),
              MaterialInfoTile('Description', '描述'),
              MaterialInfoTile('UOM', '单价'),
              MaterialInfoTile('Unit cost', '单价'),
              MaterialInfoTile('Default location', '默认库位'),
              MaterialInfoTile('QTY', '当前库存'),
              MaterialInfoTile('TECH. SPEC', '技术规范'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.more_horiz,
          ),
          onPressed: () {
            Widget page = MyRouter().findPage(
              RouterPageOption(
                url: 'router://AdvancedInfoPage',
                params: {},
              ),
            );
            Utils.pushScreen(context, page);
          },
        ));
  }
}
