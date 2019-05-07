import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/material/model/material_model.dart';
import 'package:inventory_management/route/app_state.dart';

enum MaterialListType {
  page,
  component,
}

class MaterialListState implements Cloneable<MaterialListState> {
  List<MaterialModel> list = [];
  MaterialListType type = MaterialListType.page;
  TextEditingController keywordController = TextEditingController();
  @override
  MaterialListState clone() {
    return MaterialListState()
      ..list = list
      ..type = type
      ..keywordController = keywordController;
  }
}

MaterialListState initState(Map<String, dynamic> args) {

  return MaterialListState()
    ..type = args != null ? args['type'] ?? MaterialListType.page : MaterialListType.page;
}

class MaterialListConnector extends ConnOp<AppState, MaterialListState> {
  @override
  MaterialListState get(AppState appState) {
    final MaterialListState state = appState.materialListState.clone();
    return state;
  }

  @override
  void set(AppState appState, MaterialListState subState) {
    appState.materialListState = subState.clone();
  }
}
