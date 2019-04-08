import 'package:fish_redux/fish_redux.dart';


enum MemoSaveAction { init ,switchSendMail,selectCategory,onSave}

class MemoSaveActionCreator {
  static Action init(Map<String, dynamic> parpam) {
    return Action(MemoSaveAction.init, payload: parpam);
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
