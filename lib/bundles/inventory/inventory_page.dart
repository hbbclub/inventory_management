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
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        return this.barcode = barcode;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          return this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() {
          return this.barcode = 'Unknown error: $e';
        });
      }
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
                  child: TextField(),
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 88, child: Text('Stock Code')),
                Expanded(
                  child: TextField(),
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 88, child: Text('Location')),
                Expanded(
                  child: TextField(),
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 88, child: Text('Lot Number')),
                Expanded(
                  child: TextField(),
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 88, child: Text('QTY')),
                Expanded(
                  child: TextField(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
