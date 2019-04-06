import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum OcrAction { action }

class OcrActionCreator {
  static Action onAction() {
    return const Action(OcrAction.action);
  }
}
