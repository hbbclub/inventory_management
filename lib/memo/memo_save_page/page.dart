import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MemoSavePage extends Page<MemoSaveState, Map<String, dynamic>> {
  MemoSavePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<MemoSaveState>(
                adapter: null,
                slots: <String, Dependent<MemoSaveState>>{
                }),
            middleware: <Middleware<MemoSaveState>>[
            ],);

}
