import 'package:fish_redux/fish_redux.dart';

enum MemoEditPageAction { onLoadAssets, onOcr, didOcr, onSave }

class MemoEditPageActionCreator {
  static Action onLoadAssets() {
    return const Action(MemoEditPageAction.onLoadAssets);
  }

  static Action onOcr() {
    return const Action(MemoEditPageAction.onOcr);
  }

  static Action didOcr(String text) {
    return Action(MemoEditPageAction.didOcr, payload: text);
  }

  static Action onSave() {
    return Action(MemoEditPageAction.onSave);
  }
}
