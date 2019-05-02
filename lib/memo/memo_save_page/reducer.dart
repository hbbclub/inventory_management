import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/welcome_page/model/cache_model.dart';

import 'action.dart';
import 'state.dart';

Reducer<MemoSaveState> buildReducer() {
  return asReducer(
    <Object, Reducer<MemoSaveState>>{
      MemoSaveAction.switchSendMail: _switchSendMail,
      MemoSaveAction.selectCategory: _selectCategory,
      RouteAction.route: _route,
    },
  );
}

MemoSaveState _route(MemoSaveState state, Action action) {
  final MemoSaveState newState = initState(action.payload).clone();
  List<String> categories = List.from(cacheModel.user.categories?.write ?? []);
  if (categories.length > 0 && newState.activity == null) {
    newState.activity = categories[0];
  }
  if (newState.activity != null && !categories.contains(newState.activity)) {
    categories.insert(0, newState.activity);
  }
  newState.allActivities = categories;
  return newState;
}

MemoSaveState _switchSendMail(MemoSaveState state, Action action) {
  final MemoSaveState newState = state.clone();
  newState.sendEmail = action.payload;
  return newState;
}

MemoSaveState _selectCategory(MemoSaveState state, Action action) {
  final MemoSaveState newState = state.clone();
  print(action.payload);
  print(newState.allActivities);
  newState.activity = action.payload;
  return newState;
}
