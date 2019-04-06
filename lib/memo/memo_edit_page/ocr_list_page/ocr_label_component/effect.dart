import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<OcrLabelState> buildEffect() {
  return combineEffects(<Object, Effect<OcrLabelState>>{
    // OcrLabelAction.action: _onAction,
  });
}

void _onAction(Action action, Context<OcrLabelState> ctx) {
}
