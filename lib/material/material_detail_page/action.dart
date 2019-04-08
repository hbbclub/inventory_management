import 'package:fish_redux/fish_redux.dart';

enum MaterialDetailAction { init ,pageChanged}

class MaterialDetailActionCreator {
  static Action init(Map<String, dynamic> args) {
    return Action(MaterialDetailAction.init, payload: args);
  }
  static Action pageChanged(Map<String, dynamic> args) {
    return Action(MaterialDetailAction.init, payload: args);
  }
}
