import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ScannerState state, Dispatch dispatch, ViewService viewService) {
  if (state.controller == null || !state.controller.value.isInitialized) {
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
                  controller: state.tagNumber,
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 100, child: Text('Stock Code')),
              Expanded(
                child: TextField(enabled: false, controller: state.stockNumber),
              )
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 100, child: Text('Location')),
              Expanded(
                child: TextField(enabled: false, controller: state.location),
              )
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 100, child: Text('Lot Number')),
              Expanded(
                child: TextField(enabled: false, controller: state.lotNumber),
              )
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 100, child: Text('QTY')),
              Expanded(
                child: TextField(enabled: false, controller: state.qty),
              )
            ],
          ),
          Expanded(
            child: Center(
              child: Container(
                width: double.infinity,
                height: 200,
                child: AspectRatio(
                    aspectRatio: state.controller.value.aspectRatio,
                    child: new QRReaderPreview(state.controller)),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
