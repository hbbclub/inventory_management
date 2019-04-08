import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<InfoState> buildEffect() {
  return combineEffects(<Object, Effect<InfoState>>{
    InfoAction.action: _onAction,
  });
}

void _onAction(Action action, Context<InfoState> ctx) {
}
