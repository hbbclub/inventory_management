import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/agent/api.dart';
import 'action.dart';
import 'state.dart';

Effect<MemoListTileState> buildEffect() {
  return combineEffects(<Object, Effect<MemoListTileState>>{
    MemoListTileAction.onRemove: _onRemove,
  });
}

void _onRemove(Action action, Context<MemoListTileState> ctx) async {
  await api.deleteNote(ctx.state.id);
  ctx.dispatch(MemoListTileActionCreator.remove(ctx.state.id));
}
