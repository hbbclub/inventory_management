import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<MemoImageState> buildEffect() {
  return combineEffects(<Object, Effect<MemoImageState>>{
    // MemoImageAction.action: _onAction,
  });
}

// void _onAction(Action action, Context<MemoImageState> ctx) {
// }
