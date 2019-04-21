import 'package:fish_redux/fish_redux.dart';

enum StkLabelAction { add,subtract ,onPrinterStk}

class StkLabelActionCreator {
  static Action add() {
    return const Action(StkLabelAction.add);
  }
  static Action subtract() {
    return const Action(StkLabelAction.subtract);
  }
  static Action onPrinterStk() {
    return const Action(StkLabelAction.onPrinterStk);
  }
}
