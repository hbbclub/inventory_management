import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/inventory_page/scanner_page/page.dart';
import 'package:inventory_management/inventory_page/scanner_page/state.dart';
import 'package:inventory_management/route/router.dart';
import 'action.dart';
import 'state.dart';

Effect<InventoryState> buildEffect() {
  return combineEffects(<Object, Effect<InventoryState>>{
    InventoryAction.onScan: _onScan,
  });
}

void _onScan(Action action, Context<InventoryState> ctx) async {
  ScannerState result = await appRouter
      .pushScreen(ctx.context, routerNameForScannerPage, arguments: ctx.state);

  if (result?.isfull() ?? false) {
    ctx.dispatch(InventoryActionCreator.scaned(result));
  }
}
