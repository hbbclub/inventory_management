import 'package:fish_redux/fish_redux.dart';

enum StkLabelAction { add,subtract }

class StkLabelActionCreator {
  static Action add() {
    return const Action(StkLabelAction.add);
  }
  static Action subtract() {
    return const Action(StkLabelAction.subtract);
  }
}
