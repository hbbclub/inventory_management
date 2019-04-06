import 'package:annotation_route/route.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_edit_page/memo_edit_adapter/adapter.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/state.dart'
    as memoListTileState;

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

const routerNameForMemoEditPage = 'router://MemoEditPage';
@ARoute(url: routerNameForMemoEditPage)
class MemoEditPage
    extends Page<MemoEditState, memoListTileState.MemoListTileState> {
  MemoEditPage(param)
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MemoEditState>(
              adapter: MemoEditAdapter(), slots: <String, Dependent<MemoEditState>>{}),
          middleware: <Middleware<MemoEditState>>[],
        );
}
