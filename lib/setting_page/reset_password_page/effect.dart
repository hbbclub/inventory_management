import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/route/route.route.dart';
import 'action.dart';
import 'state.dart';

Effect<ResetPasswordState> buildEffect() {
  return combineEffects(<Object, Effect<ResetPasswordState>>{
    ResetPasswordAction.onSave: _onSave,
  });
}

void _onSave(Action action, Context<ResetPasswordState> ctx) {
  router.popScreen(ctx.context);
}
