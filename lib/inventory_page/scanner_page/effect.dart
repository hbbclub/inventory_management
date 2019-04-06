import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'action.dart';
import 'state.dart';

Effect<ScannerState> buildEffect() {
  return combineEffects(<Object, Effect<ScannerState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _dispose,
  });
}

void _onInit(Action action, Context<ScannerState> ctx) async {
  ScannerState state = ctx.state.clone();
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
    ctx.dispatch(ScannerActionCreator.scaned(value));
    if (state.isfull()) {
      Navigator.of(ctx.context).pop<ScannerState>(ctx.state);
    }
    Future.delayed(
        const Duration(seconds: 2), ctx.state.controller.startScanning);
  });
  await state.controller.initialize();
  await state.controller.startScanning();
  ctx.dispatch(ScannerActionCreator.init(state));
}

void _dispose(Action action, Context<ScannerState> ctx) async {
  ctx.state.controller?.dispose();
}
