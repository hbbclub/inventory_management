import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/action.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/state.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MemoListState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter adapter = viewService.buildAdapter();

  return Scaffold(
    appBar: AppBar(
      title: Text(
        'MEMO',
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            dispatch(MemoListTileActionCreator.onEdit(MemoListTileState()));
          },
          child: Text(
            'New',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    ),
    body: Container(
      padding: EdgeInsets.only(bottom: 16),
      color: Color(0XFFEEEEEE),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 5, 8),
            color: Colors.white,
            child: TextField(
              onSubmitted: (text) {},
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {},
                  )),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, i) {
                return SizedBox(
                  height: 16,
                );
              },
              itemBuilder: adapter.itemBuilder,
              itemCount: adapter.itemCount,
            ),
          ),
        ],
      ),
    ),
  );
}
