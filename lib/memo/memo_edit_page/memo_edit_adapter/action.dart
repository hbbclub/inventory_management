import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_edit_page/memo_image_component/state.dart';

//TODO replace with your own action
enum MemoEditAction {
 loadAssets
}

class MemoEditActionCreator {
   static Action loadAssets(List<MemoImageState> list) {
    return Action(MemoEditAction.loadAssets, payload: list);
  }
}
