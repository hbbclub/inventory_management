import 'package:fish_redux/fish_redux.dart';

enum MaterialListAction { action }

class MaterialListActionCreator {
  static Action onAction() {
    return const Action(MaterialListAction.action);
  }
}
