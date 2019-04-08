import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TabState> buildReducer() {
  return asReducer(
    <Object, Reducer<TabState>>{
      TabAction.init: _init,
      TabAction.indexChanged: _indexChanged,
    },
  );
}

TabState _init(TabState state, Action action) {
  return action.payload;
}

TabState _indexChanged(TabState state, Action action) {
  final TabState newState = state.clone();
  newState.currentIndex = action.payload;
  return newState;
}
