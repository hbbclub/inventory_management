import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/material/model/material_model.dart';

class StockState implements Cloneable<StockState> {
  MaterialModel model = MaterialModel();

  @override
  StockState clone() {
    return StockState()..model = model;
  }
}

StockState initState(Map<String, dynamic> args) {
  return StockState();
}
