import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/route/route.route.dart';
import 'action.dart';
import 'state.dart';

Effect<MainState> buildEffect() {
  return combineEffects(<Object, Effect<MainState>>{
    MainAction.onEnterModule: _onEnterModule,
  });
}

void _onEnterModule(Action action, Context<MainState> ctx) {
  MainModel model = action.payload;
  router.pushScreen(ctx.context, RouterPageOption(url: model.routerName));
}
