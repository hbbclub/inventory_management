import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum OcrLabelAction { check }

class OcrLabelActionCreator {
  static Action check(String id) {
    return  Action(OcrLabelAction.check,payload: id);
  }
}
