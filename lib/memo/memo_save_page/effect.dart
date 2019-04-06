import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<MemoSaveState> buildEffect() {
  return combineEffects(<Object, Effect<MemoSaveState>>{
    MemoSaveAction.action: _onAction,
  });
}

void _onAction(Action action, Context<MemoSaveState> ctx) {
}
