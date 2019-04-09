import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/common/utils.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MemoNotesState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    width: Utils.getScreenWidth(viewService.context),
    child: TextField(
      controller: state.textEditingController,
      decoration: InputDecoration(
          hintText: 'Please enter words  here', border: InputBorder.none),
      textInputAction: TextInputAction.done,
      maxLines: null,
    ),
  );
}
