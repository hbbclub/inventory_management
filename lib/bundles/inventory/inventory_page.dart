import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/common/colors.dart';
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
            textStyle: TextStyle(color: Colors.white),
            child: Text('Save'),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 44,
        child: FlatButton(
            onPressed: scan,
            child: Column(
              children: <Widget>[
                Image.asset(
                  ImageAssets.scan,
                  color: Colors.black,
                  width: 20,
                ),
                Text('scan')
              ],
            )),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Color(0Xfff999999)),
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Tag Number',
                        labelStyle:
                            TextStyle(fontSize: 20, color: Colors.black)),
                    controller: TextEditingController(text: model.tagNumber),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Color(0Xfff999999)),
                      decoration: InputDecoration(
                          labelText: 'Stock Code',
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.black)),
                      controller:
                          TextEditingController(text: model.stockNumber)),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Color(0Xfff999999)),
                      decoration: InputDecoration(
                          labelText: 'Location',
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.black)),
                      controller: TextEditingController(text: model.location)),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Color(0Xfff999999)),
                      decoration: InputDecoration(
                          labelText: 'Lot Number',
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.black)),
                      controller: TextEditingController(text: model.lotNumber)),
                )
              ],
            ),
            Row(
              children: <Widget>[
                // SizedBox(width: 100, child: Text('QTY')),
                Expanded(
                  child: TextField(
                      style: TextStyle(color: Color(0Xfff999999)),
                      decoration: InputDecoration(
                          labelText: 'QTY',
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.black)),
                      controller:
                          TextEditingController(text: model.qty ?? '0')),
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
