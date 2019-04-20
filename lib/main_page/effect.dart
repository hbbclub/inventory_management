import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/route/router.dart';
import 'action.dart';
import 'state.dart';

Effect<MainState> buildEffect() {
  return combineEffects(<Object, Effect<MainState>>{
    MainAction.onEnterModule: _onEnterModule,
  });
}

void _onEnterModule(Action action, Context<MainState> ctx) {
  MainModel model = action.payload;
  appRouter.pushScreen(ctx.context, model.routerName);
}
