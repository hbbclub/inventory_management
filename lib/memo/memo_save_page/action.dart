import 'package:fish_redux/fish_redux.dart';


enum MemoSaveAction { init ,switchSendMail,selectCategory,onSave}

class MemoSaveActionCreator {
  static Action init() {
    return Action(MemoSaveAction.init);
  }
  static Action switchSendMail(bool send) {
    return Action(MemoSaveAction.switchSendMail, payload: send);
  }
  static Action selectCategory(String category) {
    return Action(MemoSaveAction.selectCategory, payload: category);
  }
  static Action onSave() {
    return Action(MemoSaveAction.onSave);
  }
}
