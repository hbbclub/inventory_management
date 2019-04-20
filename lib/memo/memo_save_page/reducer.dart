import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_save_page/model/memo_add_categories_model.dart';

import 'action.dart';
import 'state.dart';

Reducer<MemoSaveState> buildReducer() {
  return asReducer(
    <Object, Reducer<MemoSaveState>>{
      MemoSaveAction.init: _init,
      MemoSaveAction.switchSendMail: _switchSendMail,
      MemoSaveAction.selectCategory: _selectCategory,
      RouteAction.route: _route,
    },
  );
}

MemoSaveState _route(MemoSaveState state, Action action) {
  return initState(action.payload).clone();
}

MemoSaveState _init(MemoSaveState state, Action action) {
  final MemoSaveState newState = state.clone();
  List<CategoriesModel> allActivities = action.payload['activities'];
  newState.allActivities = allActivities;
  if (allActivities.length > 0 && newState.activity == null) {
    newState.activity = allActivities[0].category;
  }
  return newState;
}

MemoSaveState _switchSendMail(MemoSaveState state, Action action) {
  final MemoSaveState newState = state.clone();
  newState.sendEmail = action.payload;
  return newState;
}

MemoSaveState _selectCategory(MemoSaveState state, Action action) {
  final MemoSaveState newState = state.clone();
  newState.activity = action.payload;
  return newState;
}
