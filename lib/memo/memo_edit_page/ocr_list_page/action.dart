import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_edit_page/ocr_list_page/ocr_label_component/state.dart';

//TODO replace with your own action
enum OcrListAction { init ,onSubmit }

class OcrListActionCreator {
  static Action init(List<OcrLabelState> labels) {
    return Action(OcrListAction.init, payload: labels);
  }
  static Action onSubmit() {
    return Action(OcrListAction.onSubmit);
  }
}
