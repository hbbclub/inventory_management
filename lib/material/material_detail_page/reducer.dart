import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MaterialDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<MaterialDetailState>>{
      MaterialDetailAction.init: _init,
      MaterialDetailAction.selectdImage: _selectdImage,
      MaterialDetailAction.initModel: _initModel,
      RouteAction.route: _route,
    },
  );
}

MaterialDetailState _route(MaterialDetailState state, Action action) {
  return initState(action.payload).clone();
}

MaterialDetailState _init(MaterialDetailState state, Action action) {
  final MaterialDetailState newState = state.clone();
  newState.mTabController = action.payload['tab'];
  return newState;
}

MaterialDetailState _initModel(MaterialDetailState state, Action action) {
  final MaterialDetailState newState = state.clone();
  newState.model = action.payload;
  return newState;
}

MaterialDetailState _selectdImage(MaterialDetailState state, Action action) {
  final MaterialDetailState newState = state.clone();
  return newState;
}
