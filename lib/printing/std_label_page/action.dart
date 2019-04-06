import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/printing/std_label_page/std_component/state.dart';

enum StdLabelAction { init, onInit }

class StdLabelActionCreator {
  static Action init(List<StdState> labels) {
    return Action(StdLabelAction.init, payload: labels);
  }

  static Action onInit() {
    return const Action(StdLabelAction.onInit);
  }
}
