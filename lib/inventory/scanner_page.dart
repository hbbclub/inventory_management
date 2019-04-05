import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:inventory_management/inventory/inventory_page.dart';

List<CameraDescription> cameras;

class CameraApp extends StatefulWidget {
  final InventoryModel model;
  CameraApp(this.model);
  @override
  _CameraAppState createState() => new _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  QRReaderController controller;

  @override
  void initState() {
    super.initState();
    availableCameras().then((list) {
      cameras = list;
      controller = new QRReaderController(cameras[0], ResolutionPreset.medium, [
        CodeFormat.qr,
        CodeFormat.code128,
        CodeFormat.code39,
        CodeFormat.code93,
      ], (dynamic value) {
        print(value); // the result!

        if (RegExp(r"^[T].*").matchAsPrefix(value) != null) {
          setState(() {
            widget.model.tagNumber = value;
          });
        } else if (RegExp(r"^[S].*").matchAsPrefix(value) != null) {
          setState(() {
            widget.model.stockNumber = value;
          });
        } else if (RegExp(r"^[Q].*").matchAsPrefix(value) != null) {
          setState(() {
            widget.model.qty = value;
          });
        } else if (RegExp(r"^[N].*").matchAsPrefix(value) != null) {
          setState(() {
            widget.model.lotNumber = value;
          });
        } else if (RegExp(r"^[L].*").matchAsPrefix(value) != null) {
          setState(() {
            widget.model.location = value;
          });
        }
        if (widget.model.isfull()) {
          Navigator.of(context).pop();
        }

        new Future.delayed(
            const Duration(seconds: 2), controller.startScanning);
      });
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }

        setState(() {});
        controller.startScanning();
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return new Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 100, child: Text('Tag Number')),
                Expanded(
                  child: TextField(
                    enabled: false,
                    controller:
                        TextEditingController(text: widget.model.tagNumber),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 100, child: Text('Stock Code')),
                Expanded(
                  child: TextField(
                      enabled: false,
                      controller: TextEditingController(
                          text: widget.model.stockNumber)),
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 100, child: Text('Location')),
                Expanded(
                  child: TextField(
                      enabled: false,
                      controller:
                          TextEditingController(text: widget.model.location)),
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 100, child: Text('Lot Number')),
                Expanded(
                  child: TextField(
                      enabled: false,
                      controller:
                          TextEditingController(text: widget.model.lotNumber)),
                )
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 100, child: Text('QTY')),
                Expanded(
                  child: TextField(
                      enabled: false,
                      controller:
                          TextEditingController(text: widget.model.qty)),
                )
              ],
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: new QRReaderPreview(controller)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
