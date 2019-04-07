import 'package:annotation_route/route.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

const routerNameForMemoSavePage = 'router://MemoSavePage';

@ARoute(url: routerNameForMemoSavePage)
class MemoSavePage extends Page<MemoSaveState, Map<String, dynamic>> {
  MemoSavePage(param)
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MemoSaveState>(
              adapter: null, slots: <String, Dependent<MemoSaveState>>{}),
          middleware: <Middleware<MemoSaveState>>[],
        );
}
