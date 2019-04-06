import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    OcrLabelState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    // height: 60,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(3.0)),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
                labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                border: InputBorder.none),
            maxLines: null,
            controller: TextEditingController(text: state.text),
          ),
        ),
        IconButton(
          icon: Icon(Icons.check),
          onPressed: () => dispatch(OcrLabelActionCreator.check(state.id)),
        )
      ],
    ),
  );
  
}
