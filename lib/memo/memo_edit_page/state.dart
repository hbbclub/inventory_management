import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/memo/memo_edit_page/memo_image_component/state.dart';
import 'package:inventory_management/memo/memo_edit_page/memo_notes_component/state.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/state.dart';

enum NotePageType {
  Edit,
  Add,
}

class MemoEditState implements Cloneable<MemoEditState> {
  List<dynamic> images = [];
  MemoListTileState listTileState = MemoListTileState();

  @override
  MemoEditState clone() {
    return MemoEditState()
      ..listTileState = listTileState.clone()
      ..images = images;
    // ..textEditingController = textEditingController;
  }
}

MemoEditState initState(MemoListTileState args) {
  List images = [MemoNotesState()..textEditingController.text = args.notes];
  images.addAll(args.files ?? []);
 
  return MemoEditState()
    // ..textEditingController = TextEditingController(text: args.notes)
    ..listTileState = args.clone()
    ..images = images;
}
