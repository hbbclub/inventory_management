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
    String platformVersion;
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
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

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
                    'stockCode': '11',
                    'desc': 'aaa',
                    'lotNumber': '123',
                    'qty': '1',
                    'location': 'hahah',
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
