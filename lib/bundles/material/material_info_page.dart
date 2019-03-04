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

class MaterialInfoPageState extends State<MaterialInfoPage>
    with AutomaticKeepAliveClientMixin {
  TextEditingController controller;
  MaterialModel model = MaterialModel();
  @override
  void initState() {
    super.initState();
    controller = TextEditingController.fromValue(TextEditingValue.empty);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                onTap: () async {
                  MaterialBloc bloc = BlocProvider.of<MaterialBloc>(context);
                  await showSearch(
                    delegate: SearchMaterial(bloc),
                    context: context,
                  );
                  setState(() {
                    model = bloc.resultModel;
                  });
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
              (model.imgs != null
                  ? FadeInImage(
                      placeholder: AssetImage(ImageAssets.materalIcon),
                      image: NetworkImage(model.imgs.first.url),
                    )
                  : Image.asset(ImageAssets.materalIcon)),
              MaterialInfoTile('Stock Code', model.partNo ?? ''),
              MaterialInfoTile('Description', model.desc ?? ''),
              MaterialInfoTile('UOM', model.uom ?? ''),
              MaterialInfoTile('Unit cost', (model.unitCost ?? 0).toString()),
              MaterialInfoTile('Default location', model.loc ?? ''),
              MaterialInfoTile('QTY', (model.sapQty ?? 0).toString()),
              MaterialInfoTile('TECH. SPEC', '技术规范'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "moreInfo",
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

  @override
  bool get wantKeepAlive => true;
}
