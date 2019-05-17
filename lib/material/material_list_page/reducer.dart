import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/material/model/material_model.dart';

import 'action.dart';
import 'state.dart';

Reducer<MaterialListState> buildReducer() {
  return asReducer(
    <Object, Reducer<MaterialListState>>{
      MaterialListAction.init: _init,
      RouteAction.route: _route,
      MaterialListAction.clearSearch: _clearSearch,
      MaterialListAction.scaned: _scaned,
    },
  );
}

MaterialListState _clearSearch(MaterialListState state, Action action) {
  final MaterialListState newState = state.clone();
  newState.keywordController.text = '';
  return newState;
}

MaterialListState _scaned(MaterialListState state, Action action) {
  final MaterialListState newState = state.clone();
  newState.keywordController.text = action.payload;
  return newState;
}

MaterialListState _init(MaterialListState state, Action action) {
  final List<MaterialModel> list = action.payload ?? <MaterialModel>[];
  final MaterialListState newState = state.clone();
  newState.list = list;
  return newState;
}

MaterialListState _route(MaterialListState state, Action action) {
  return initState(action.payload).clone();
}
