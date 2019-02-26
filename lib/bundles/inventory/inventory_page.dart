import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'dart:async';
import 'package:flutter/services.dart';

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
    try {
      while (true) {
        String barcode = await BarcodeScanner.scan();
        print(barcode);
        if (RegExp(r"^[T].*").matchAsPrefix(barcode) != null) {
          setState(() {
            model.tagNumber = barcode;
          });
        } else if (RegExp(r"^[S].*").matchAsPrefix(barcode) != null) {
          print(11111);
          setState(() {
            model.stockNumber = barcode;
          });
        } else if (RegExp(r"^[Q].*").matchAsPrefix(barcode) != null) {
          setState(() {
            model.qty = barcode;
          });
        } else if (RegExp(r"^[N].*").matchAsPrefix(barcode) != null) {
          setState(() {
            model.lotNumber = barcode;
          });
        } else if (RegExp(r"^[L].*").matchAsPrefix(barcode) != null) {
          setState(() {
            model.location = barcode;
          });
        }
        if (model.isfull()) {
          break;
        }
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
      } else {}
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory'),
        actions: <Widget>[
          RawMaterialButton(
            child: Text(
              'done',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.scanner),
        onPressed: scan,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 88, child: Text('Tag Number')),
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: model.tagNumber),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 88, child: Text('Stock Code')),
                Expanded(
                  child: TextField(
                      controller:
                          TextEditingController(text: model.stockNumber)),
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 88, child: Text('Location')),
                Expanded(
                  child: TextField(
                      controller: TextEditingController(text: model.location)),
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 88, child: Text('Lot Number')),
                Expanded(
                  child: TextField(
                      controller: TextEditingController(text: model.lotNumber)),
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 88, child: Text('QTY')),
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
