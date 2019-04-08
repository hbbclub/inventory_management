import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<StockState> buildEffect() {
  return combineEffects(<Object, Effect<StockState>>{
    StockAction.action: _onAction,
  });
}

void _onAction(Action action, Context<StockState> ctx) {
}
