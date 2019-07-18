import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/common/utils.dart';

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
              SizedBox(
                  width: 140,
                  child: Text(
                    'Tag Number',
                    style: TextStyle(fontSize: 20),
                  )),
              Expanded(
                child: TextField(
                  controller: state.tagNumber,
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                  width: 140,
                  child: Text('Stock Code', style: TextStyle(fontSize: 20))),
              Expanded(
                child: TextField(
                  controller: state.stockNumber,
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                  width: 140,
                  child: Text('Location', style: TextStyle(fontSize: 20))),
              Expanded(
                child: TextField(
                  controller: state.location,
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                  width: 140,
                  child: Text('Lot Number', style: TextStyle(fontSize: 20))),
              Expanded(
                child: TextField(
                  controller: state.lotNumber,
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                  width: 140,
                  child: Text('QTY', style: TextStyle(fontSize: 20))),
              Expanded(
                child: TextField(
                  controller: state.qty,
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
          Expanded(
            child: Center(
              child: Container(
                width: Utils.getScreenWidth(viewService.context),
                height: Utils.getScreenWidth(viewService.context),
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
