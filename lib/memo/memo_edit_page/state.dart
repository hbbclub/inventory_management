import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/memo/memo_edit_page/memo_image_component/state.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/state.dart';

enum NotePageType {
  Edit,
  Add,
}

class MemoEditState implements Cloneable<MemoEditState> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextRecognizer textDetector = FirebaseVision.instance.textRecognizer();
  List<MemoImageState> images = [];
  TextEditingController textEditingController = TextEditingController();
  NotePageType type;
  @override
  MemoEditState clone() {
    return MemoEditState()
      ..scaffoldKey = scaffoldKey
      ..textDetector = textDetector
      ..images = images
      ..textEditingController = textEditingController;
  }
}

MemoEditState initState(MemoListTileState args) {
  return MemoEditState()
    ..textEditingController = TextEditingController(text: args.notes)
    ..type = args.id == null ? NotePageType.Add : NotePageType.Edit
    ..images = args.files ?? [];
}
