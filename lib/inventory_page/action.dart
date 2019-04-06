import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/inventory_page/scanner_page/state.dart';

enum InventoryAction { add, subtract, onScan, scaned }

class InventoryActionCreator {
  static Action add() {
    return const Action(InventoryAction.add);
  }

  static Action subtract() {
    return const Action(InventoryAction.subtract);
  }

  static Action onScan() {
    return const Action(InventoryAction.onScan);
  }

  static Action scaned(ScannerState state) {
    return Action(InventoryAction.scaned, payload: state);
  }
}
