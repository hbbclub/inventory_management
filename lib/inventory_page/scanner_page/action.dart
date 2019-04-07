import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/inventory_page/scanner_page/state.dart';
enum ScannerAction { init, scaned }

class ScannerActionCreator {
  static Action init(ScannerState state) {
    return Action(ScannerAction.init, payload: state);
  }

  static Action scaned(String code) {
    return Action(ScannerAction.scaned, payload: code);
  }
}
