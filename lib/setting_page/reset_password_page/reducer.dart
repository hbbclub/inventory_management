import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ResetPasswordState> buildReducer() {
  return asReducer(
    <Object, Reducer<ResetPasswordState>>{
      // ResetPasswordAction.action: _onAction,
    },
  );
}

// ResetPasswordState _onAction(ResetPasswordState state, Action action) {
//   final ResetPasswordState newState = state.clone();
//   return newState;
// }
