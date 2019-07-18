import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/common/keep_alive_widget.dart';
import 'package:inventory_management/memo/memo_edit_page/memo_edit_adapter/adapter.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/state.dart'
    as memoListTileState;

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

const routerNameForMemoEditPage = 'router://MemoEditPage';

class MemoEditPage
    extends Page<MemoEditState, memoListTileState.MemoListTileState> {
  MemoEditPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MemoEditState>(
              adapter: MemoEditAdapter(),
              slots: <String, Dependent<MemoEditState>>{}),
          middleware: <Middleware<MemoEditState>>[],
          wrapper: wrapperFunc,
        );
  static Widget wrapperFunc(Widget widget) {
    return KeepAliveWidget(
      widget,
    );
  }
}
