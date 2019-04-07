import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/material/model/material_model.dart';

class AdvancedState implements Cloneable<AdvancedState> {
  MaterialModel model = MaterialModel();

  @override
  AdvancedState clone() {
    return AdvancedState()..model = model;
  }
}

AdvancedState initState(Map<String, dynamic> args) {
  return AdvancedState();
}
