import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_edit_page/memo_notes_component/state.dart';

import 'action.dart';
import 'state.dart';

Reducer<MemoEditState> buildReducer() {
  return asReducer(
    <Object, Reducer<MemoEditState>>{
      MemoEditPageAction.didOcr: _didOcr,
    },
  );
}

MemoEditState _didOcr(MemoEditState state, Action action) {
  MemoEditState newState = state.clone();
  MemoNotesState textState = newState.images[0];
  textState.textEditingController.text =
      textState.textEditingController.text + action.payload;
  return newState;
}
