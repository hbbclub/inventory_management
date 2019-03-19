import 'package:flutter/material.dart';
import 'dart:async';
import 'package:inventory_management/bundles/common/images.dart';
import 'package:inventory_management/bundles/common/utils.dart';
import 'package:inventory_management/bundles/inventory/scanner_page.dart';

class InventoryPage extends StatefulWidget {
  @override
  InventoryPageState createState() {
    return new InventoryPageState();
  }
}

class InventoryPageState extends State<InventoryPage> {
  String barcode = "";
  InventoryModel model = InventoryModel();
  Future scan() async {
    Utils.pushScreen(context, CameraApp(model));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('INVENTORY'),
        actions: <Widget>[
          RawMaterialButton(
            child: Icon(
              Icons.save,
              size: 35,
            ),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Image.asset(
          ImageAssets.scan,
          width: 20,
        ),
        onPressed: scan,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 100, child: Text('Tag Number')),
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: model.tagNumber),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 100, child: Text('Stock Code')),
                Expanded(
                  child: TextField(
                      controller:
                          TextEditingController(text: model.stockNumber)),
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 100, child: Text('Location')),
                Expanded(
                  child: TextField(
                      controller: TextEditingController(text: model.location)),
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 100, child: Text('Lot Number')),
                Expanded(
                  child: TextField(
                      controller: TextEditingController(text: model.lotNumber)),
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 100, child: Text('QTY')),
                Expanded(
                  child: TextField(
                      controller: TextEditingController(text: model.qty)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InventoryModel {
  String tagNumber;
  String stockNumber;
  String location;
  String lotNumber;
  String qty;

  bool isfull() {
    return tagNumber != null &&
        stockNumber != null &&
        location != null &&
        lotNumber != null &&
        qty != null;
  }
}
