import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PrintingState> buildReducer() {
  return asReducer(
    <Object, Reducer<PrintingState>>{
      PrintingAction.init: _init,
      RouteAction.route: _route,
    },
  );
}

PrintingState _route(PrintingState state, Action action) {
  return initState(action.payload).clone();
}

PrintingState _init(PrintingState state, Action action) {
  final PrintingState newState = action.payload;
  return newState;
}
