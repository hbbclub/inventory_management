import 'package:fish_redux/fish_redux.dart';

enum OcrAction { action }

class OcrActionCreator {
  static Action onAction() {
    return const Action(OcrAction.action);
  }
}
