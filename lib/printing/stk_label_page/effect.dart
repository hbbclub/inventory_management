import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<StkLabelState> buildEffect() {
  return combineEffects(<Object, Effect<StkLabelState>>{
    // StkLabelAction.action: _onAction,
  });
}

// void _onAction(Action action, Context<StkLabelState> ctx) {
// }
