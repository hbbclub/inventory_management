import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/printing/std_label_page/std_component/state.dart';

class StdLabelState implements Cloneable<StdLabelState> {
  List<StdState> labels = [];
  @override
  StdLabelState clone() {
    return StdLabelState()..labels = labels;
  }
}

StdLabelState initState(Map<String, dynamic> args) {
  return StdLabelState();
}
