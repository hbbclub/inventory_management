import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class MemoNotesState implements Cloneable<MemoNotesState> {
  TextEditingController textEditingController = TextEditingController();

  @override
  MemoNotesState clone() {
    return MemoNotesState();
  }
}

MemoNotesState initState(Map<String, dynamic> args) {
  return MemoNotesState();
}
