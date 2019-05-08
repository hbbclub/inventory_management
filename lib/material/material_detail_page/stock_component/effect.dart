import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/material/model/material_model.dart';
import 'action.dart';
import 'state.dart';

Effect<StockState> buildEffect() {
  return combineEffects(<Object, Effect<StockState>>{
    Lifecycle.initState: _oninit,
  });
}

void _oninit(Action action, Context<StockState> ctx) {
  if (ctx.state.model?.stocks?.loc?.length != null &&
      ctx.state.model.stocks.loc.length > 0) {
    List<StockTileModel> list =
        List.generate(ctx.state.model.stocks.loc.length, (index) {
      return StockTileModel('loc', ctx.state.model.stocks.loc[index]);
    }).toList();
    list.add(StockTileModel('total', ctx.state.model.stocks.total.toString()));
    ctx.dispatch(StockActionCreator.init(list));
  } else {
    ctx.dispatch(StockActionCreator.init([StockTileModel('total', '0')]));
  }
}
