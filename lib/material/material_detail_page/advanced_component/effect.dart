import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<AdvancedState> buildEffect() {
  return combineEffects(<Object, Effect<AdvancedState>>{
    AdvancedAction.action: _onAction,
  });
}

void _onAction(Action action, Context<AdvancedState> ctx) {
}
