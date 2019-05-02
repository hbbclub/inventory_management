import 'package:fish_redux/fish_redux.dart';


enum MemoSaveAction { switchSendMail,selectCategory,onSave}

class MemoSaveActionCreator {
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
