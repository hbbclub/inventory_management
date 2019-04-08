import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/printing/std_label_page/state.dart';

import 'action.dart';


Reducer<StdLabelState> buildReducer() {
  return asReducer(
    <Object, Reducer<StdLabelState>>{
      // StdAction.action: _onAction,
    },
  );
}
