import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MaterialDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<MaterialDetailState>>{
      MaterialDetailAction.init: _init,
    },
  );
}

MaterialDetailState _init(MaterialDetailState state, Action action) {
  final MaterialDetailState newState = state.clone();
  newState.mTabController = action.payload['tab'];
  return newState;
}
