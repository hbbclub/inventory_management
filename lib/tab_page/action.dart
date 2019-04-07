import 'package:fish_redux/fish_redux.dart';

enum TabAction { indexChanged, onIndexChanged, init }

class TabActionCreator {
  static Action init(state) {
    return Action(TabAction.init, payload: state);
  }

  static Action indexChanged(int index) {
    return Action(TabAction.indexChanged, payload: index);
  }

  static Action onIndexChanged(int index) {
    return Action(TabAction.onIndexChanged, payload: index);
  }
}
