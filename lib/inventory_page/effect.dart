import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/inventory_page/scanner_page/page.dart';
import 'package:inventory_management/inventory_page/scanner_page/state.dart';
import 'package:inventory_management/route/router.dart';
import 'action.dart';
import 'state.dart';

Effect<InventoryState> buildEffect() {
  return combineEffects(<Object, Effect<InventoryState>>{
    InventoryAction.onScan: _onScan,
    Lifecycle.dispose: _dispose,
    Lifecycle.initState: _onInit,
  });
}

void _onInit(Action action, Context<InventoryState> ctx) async {
  InventoryState state = ctx.state.clone();
  try {
    state.cameras = await availableCameras();
    state.controller =
        QRReaderController(state.cameras[0], ResolutionPreset.medium, [
      CodeFormat.qr,
      CodeFormat.code128,
      CodeFormat.code39,
      CodeFormat.code93,
    ], (dynamic value) {
      if (value == null) {
        return;
      }
      state.player.playLocal();
      ctx.dispatch(InventoryActionCreator.scaned(value));
      Future.delayed(
          const Duration(seconds: 1), ctx.state.controller.startScanning);
    });
    await state.controller.initialize();
    ctx.dispatch(InventoryActionCreator.init(state));
    await state.controller.startScanning();
  } catch (e) {
    state.cameras = [];
  }
}

void _onScan(Action action, Context<InventoryState> ctx) async {
  ScannerState result = await appRouter
      .pushScreen(ctx.context, routerNameForScannerPage, arguments: ctx.state);

  if (result?.isfull() ?? false) {
    // ctx.dispatch(InventoryActionCreator.scaned(result));
  }
}

void _dispose(Action action, Context<InventoryState> ctx) async {
  ctx.state.controller?.dispose();
}
