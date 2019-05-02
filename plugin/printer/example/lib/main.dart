import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:printer/printer.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List datas = [];
  String connState;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      Printer.init((aa) {
        if (aa['type'] == 'data') {
          if (!mounted) return;
          setState(() {
            datas = aa['data'];
          });
        } else {
          if (!mounted) return;
          setState(() {
            connState = aa['data'];
          });
        }
      });
      await Printer.start();
    } on PlatformException {}

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

//{type: stk, data: {_id: 5c76591dd33ed7d8ff5adb66, part_no: AS11234AD, loc: SB01, desc: LH ARM AND BLADE ASY, uom: EA, unitCost: null, sap_qty: 22, tech_spec: null, count: 1}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(connState),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Printer.print({
                  'type': 'stk',
                  'data': {
                    'part_no': 'AS11234AD',
                    'desc': 'TEST TEST TEST TEST TEST TEST',
                    'lot': '111',
                    'sap_qty': '22',
                    'loc': 'test',
                    'uom': 'EA',
                    'count': 1,
                  }
                });
              },
              child: Text(
                'Print',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: Center(
            child: ListView(
          children: datas.map((item) {
            return ListTile(
              title: Text(item['name']),
              onTap: () {
                Printer.connect(item['uuid']);
              },
            );
          }).toList(),
        )),
      ),
    );
  }
}
