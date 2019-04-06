import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/common/utils.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MemoEditState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter adapter = viewService.buildAdapter();

  return Scaffold(
    key: state.scaffoldKey,
    appBar: AppBar(
      title: Text(
        state.type == NotePageType.Add ? 'Add Note' : 'Note Detail',
      ),
      actions: <Widget>[
        RawMaterialButton(
          textStyle: TextStyle(color: Colors.white),
          child: Text('Save'),
          onPressed: () {
            // Widget page = MyRouter().findPage(
            //   RouterPageOption(
            //     url: 'router://MemoSaveNotePage',
            //     params: {
            //       'files': images ?? [],
            //       'notes': _textEditingController.text,
            //       'items': _currentTextLabels ?? [],
            //       'type': widget.initParam.params['type'],
            //       'id': widget.initParam.params['model']?.id,
            //     },
            //   ),
            // );
            // Utils.pushScreen(context, page);
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
          Container(
            width: Utils.getScreenWidth(viewService.context),
            child: TextField(
              controller: state.textEditingController,
              decoration: InputDecoration(
                  hintText: 'Please enter words  here',
                  border: InputBorder.none),
              textInputAction: TextInputAction.done,
              maxLines: 5,
            ),
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
    bottomNavigationBar: Container(
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
            child:
                Column(children: <Widget>[Icon(Icons.camera_alt), Text('Ocr')]),
            onPressed: () async {
              dispatch(MemoEditPageActionCreator.onOcr());
            },
          ),
        ],
      ),
    ),
  );
}
