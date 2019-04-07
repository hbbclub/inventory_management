import 'package:fish_redux/fish_redux.dart';

enum OcrLabelAction { check }

class OcrLabelActionCreator {
  static Action check(String id) {
    return Action(OcrLabelAction.check, payload: id);
  }
}
