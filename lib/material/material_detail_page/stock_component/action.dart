import 'package:fish_redux/fish_redux.dart';

enum StockAction { action }

class StockActionCreator {
  static Action onAction() {
    return const Action(StockAction.action);
  }
}
