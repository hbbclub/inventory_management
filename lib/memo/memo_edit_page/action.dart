import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_edit_page/memo_image_component/state.dart';
import 'package:multi_image_picker/asset.dart';

//TODO replace with your own action
enum MemoEditPageAction {  onLoadAssets ,onOcr,didOcr}

class MemoEditPageActionCreator {
  static Action onLoadAssets() {
    return const Action(MemoEditPageAction.onLoadAssets);
  }
  static Action onOcr() {
    return const Action(MemoEditPageAction.onOcr);
  }
  static Action didOcr(String text) {
    return  Action(MemoEditPageAction.didOcr,payload: text);
  }

 
}
