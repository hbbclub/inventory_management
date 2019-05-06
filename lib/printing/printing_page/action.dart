import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/printing/printing_page/state.dart';

enum PrintingAction { action, init }

class PrintingActionCreator {
  static Action init(PrintingState state) {
    return Action(PrintingAction.init, payload: state);
  }
}
