import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/common/multi_image_picker/asset_view.dart';
import 'package:inventory_management/common/utils.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MemoImageState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    width: 150.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 40,
        ),
        Expanded(
          child: state.url != null
              ? Image.network('http://' + Utils.hostUri + '/' + state.url)
              : state.asset != null
                  ? AssetView(Key(state.asset.identifier), 0, state.asset)
                  : Container(),
        ),
        IconButton(
          icon: Icon(
            Icons.cancel,
          ),
          onPressed: () => dispatch(MemoImageActionCreator.remove(state.id)),
        )
      ],
    ),
  );
}
