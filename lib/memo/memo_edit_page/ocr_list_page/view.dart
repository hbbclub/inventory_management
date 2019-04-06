import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    OcrListState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter adapter = viewService.buildAdapter();

  return Scaffold(
    appBar: AppBar(
      title: Text(
        'OCR Result',
      ),
      actions: <Widget>[
        RawMaterialButton(
          textStyle: TextStyle(color: Colors.white),
          child: Text('Submit'),
          onPressed: () {},
        ),
      ],
    ),
    body: Container(
      color: Color(0XffEEEEEE),
      padding: EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: adapter.itemCount,
        itemBuilder: adapter.itemBuilder,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 8,
          );
        },
      ),
    ),
  );
}
