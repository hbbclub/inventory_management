import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/material/model/material_model.dart';

enum StockAction { init }

class StockActionCreator {
  static Action init(List<StockTileModel> list) {
    return Action(StockAction.init, payload: list);
  }
}
