import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_adapter/adapter.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

const routerNameForMemoListPage = 'router://MemoListPage';

class MemoListPage extends Page<MemoListState, Map<String, dynamic>> {
  MemoListPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MemoListState>(
              adapter: MemoListAdapter(),
              slots: <String, Dependent<MemoListState>>{}),
          middleware: <Middleware<MemoListState>>[],
        );
}
