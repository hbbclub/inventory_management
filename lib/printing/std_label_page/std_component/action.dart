import 'package:fish_redux/fish_redux.dart';

enum StdAction { add, subtract }

class StdActionCreator {
  static Action add() {
    return const Action(StdAction.add);
  }

  static Action subtract() {
    return const Action(StdAction.subtract);
  }
}
