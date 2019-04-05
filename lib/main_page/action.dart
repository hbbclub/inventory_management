import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/main_page/state.dart';

enum MainAction { onEnterModule }

class MainActionCreator {
  static Action onEnterModule(MainModel modle) {
    return Action(MainAction.onEnterModule, payload: modle);
  }
}
