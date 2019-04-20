import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/printing/std_label_page/std_component/state.dart';
import 'package:inventory_management/route/app_state.dart';

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


class StdLabelConnector extends ConnOp<AppState, StdLabelState> {
  @override
  StdLabelState get(AppState appState) {
    final StdLabelState state = appState.stdLabelState.clone();
    return state;
  }

  @override
  void set(AppState appState, StdLabelState subState) {

    appState.stdLabelState = subState.clone();
  }
}