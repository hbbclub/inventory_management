import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MemoEditState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter adapter = viewService.buildAdapter();

  return Scaffold(
    appBar: AppBar(
      title: Text(
        state.listTileState.id == null ? 'Add Note' : 'Note Detail',
      ),
      actions: <Widget>[
        RawMaterialButton(
          textStyle: TextStyle(color: Colors.white),
          child: Text('Save'),
          onPressed: () {
            dispatch(MemoEditPageActionCreator.onSave());
          },
        ),
      ],
    ),
    body: Container(
      color: Color(0XffEEEEEE),
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 10.0,
          ),
          Expanded(
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
        ],
      ),
    ),
    bottomNavigationBar: SafeArea(
      child: Container(
        color: Colors.white,
        height: 44,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton(
                child: Column(
                    children: <Widget>[Icon(Icons.image), Text('Gallary')]),
                onPressed: () {
                  dispatch(MemoEditPageActionCreator.onLoadAssets());
                }),
            FlatButton(
              child: Column(
                  children: <Widget>[Icon(Icons.camera_alt), Text('Ocr')]),
              onPressed: () async {
                dispatch(MemoEditPageActionCreator.onOcr());
              },
            ),
          ],
        ),
      ),
    ),
  );
}
