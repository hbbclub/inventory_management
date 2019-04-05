import 'package:flutter/material.dart';
import 'package:inventory_management/common/colors.dart';
import 'dart:async';
import 'package:inventory_management/common/images.dart';
import 'package:inventory_management/common/utils.dart';
import 'package:inventory_management/inventory/scanner_page.dart';

class InventoryPage extends StatefulWidget {
  @override
  InventoryPageState createState() {
    return new InventoryPageState();
  }
}

class InventoryPageState extends State<InventoryPage> {
  String barcode = "";
  InventoryModel model = InventoryModel();
  TextEditingController qtyController = TextEditingController();
  Future scan() async {
    Utils.pushScreen(context, CameraApp(model));
  }

  @override
  Widget build(BuildContext context) {
    qtyController.text = model.qty ?? '0';
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
                        border: InputBorder.none,
                        labelText: 'Tag Number',
                        hintText: 'Please enter tag number',
                        hintStyle:
                            TextStyle(fontSize: 16, color: Color(0XFF999999)),
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
                      border: InputBorder.none,
                      labelText: 'Stock Code',
                      hintText: 'Please enter stock code',
                      hintStyle:
                          TextStyle(fontSize: 16, color: Color(0XFF999999)),
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    controller: TextEditingController(text: model.stockNumber),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                      style: TextStyle(color: Color(0Xfff999999)),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Location',
                          hintText: 'Please enter location',
                          hintStyle:
                              TextStyle(fontSize: 16, color: Color(0XFF999999)),
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
                          border: InputBorder.none,
                          labelText: 'Lot Number',
                          hintText: 'Please enter lot number',
                          hintStyle:
                              TextStyle(fontSize: 16, color: Color(0XFF999999)),
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
                      border: InputBorder.none,
                      labelText: 'QTY',
                      hintText: 'Please enter qty',
                      hintStyle:
                          TextStyle(fontSize: 16, color: Color(0XFF999999)),
                      labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                      suffixIcon: Container(
                        // color: Colors.white,
                        width: 100,
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                if (int.parse(qtyController.text) <= 0) {
                                  return;
                                }
                                qtyController.text =
                                    (int.parse(qtyController.text) - 1)
                                        .toString();
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline),
                              onPressed: () {
                                qtyController.text =
                                    (int.parse(qtyController.text) + 1)
                                        .toString();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    controller: qtyController,
                  ),
                ),
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
