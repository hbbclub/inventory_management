import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/memo/memo_edit_page/memo_image_component/state.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/state.dart';
import 'package:inventory_management/memo/memo_save_page/model/memo_add_categories_model.dart';

class MemoSaveState implements Cloneable<MemoSaveState> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController keywordController = TextEditingController();
  bool sendEmail = false;
  String notes = '';

  String activity;
  List<CategoriesModel> allActivities = [];
  List<MemoImageState> images = [];
  MemoListTileState listTileState = MemoListTileState();

  @override
  MemoSaveState clone() {
    return MemoSaveState()
      ..scaffoldKey = scaffoldKey
      ..keywordController = keywordController
      ..sendEmail = sendEmail
      ..notes = notes
      ..activity = activity
      ..images = images
      ..listTileState = listTileState.clone()
      ..allActivities = allActivities;
  }
}

MemoSaveState initState(Map<String, dynamic> args) {
  MemoListTileState state = args['tileState'];
  return MemoSaveState()
    ..notes = args['notes']
    ..listTileState = state
    ..keywordController = TextEditingController(text: state.keyword)
    ..activity = state.category
    ..images = args['images'];
}

class SettingItem {
  Function onDone;
  Widget child;
  SettingItem({this.onDone, this.child});
}
