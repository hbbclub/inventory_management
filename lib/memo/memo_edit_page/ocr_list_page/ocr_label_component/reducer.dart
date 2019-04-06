import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<OcrLabelState> buildReducer() {
  
  return asReducer(
    <Object, Reducer<OcrLabelState>>{
      // OcrLabelAction.action: _onAction,
    },
  );
}

// OcrLabelState _onAction(OcrLabelState state, Action action) {
//   final OcrLabelState newState = state.clone();
//   return newState;
// }
