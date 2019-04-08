import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ScannerState> buildReducer() {
  return asReducer(
    <Object, Reducer<ScannerState>>{
      ScannerAction.init: _init,
      ScannerAction.scaned: _scaned,
    },
  );
}

ScannerState _init(ScannerState state, Action action) {
  ScannerState payload =action.payload;
  final ScannerState newState = state.clone();
  newState.controller = payload.controller;
  newState.cameras = payload.cameras;
  return newState;
}

ScannerState _scaned(ScannerState state, Action action) {
  String code = action.payload;
  final ScannerState newState = state.clone();
  if (RegExp(r"^[T].*").matchAsPrefix(code) != null) {
    newState.tagNumber.text = code;
  } else if (RegExp(r"^[S].*").matchAsPrefix(code) != null) {
    newState.stockNumber.text = code;
  } else if (RegExp(r"^[Q].*").matchAsPrefix(code) != null) {
    newState.qty.text = code;
  } else if (RegExp(r"^[N].*").matchAsPrefix(code) != null) {
    newState.lotNumber.text = code;
  } else if (RegExp(r"^[L].*").matchAsPrefix(code) != null) {
    newState.location.text = code;
  }
  return newState;
}
