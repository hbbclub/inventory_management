import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/route/app_state.dart';

class MaterialListState implements Cloneable<MaterialListState> {

  @override
  MaterialListState clone() {
    return MaterialListState();
  }
}

MaterialListState initState(Map<String, dynamic> args) {
  return MaterialListState();
}


class MaterialListConnector extends ConnOp<AppState, MaterialListState> {
  @override
  MaterialListState get(AppState appState) {
    final MaterialListState state = appState.materialListState.clone();
    return state;
  }

  @override
  void set(AppState appState, MaterialListState subState) {

    appState.materialListState = subState.clone();
  }
}