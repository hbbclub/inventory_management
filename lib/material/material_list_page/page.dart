import 'package:annotation_route/route.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/bloc/bloc_provider.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

const routerNameForMaterialListPage = 'router://MaterialListPage';

@ARoute(url: routerNameForMaterialListPage)
class MaterialListPage extends Page<MaterialListState, Map<String, dynamic>> {
  MaterialListPage(param)
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MaterialListState>(
              adapter: null, slots: <String, Dependent<MaterialListState>>{}),
          middleware: <Middleware<MaterialListState>>[],
          wrapper: wrapperFunc,
        );

//加入bloc
  static Widget wrapperFunc(Widget widget) {
    return BlocProvider(bloc: MaterialBloc(), child: widget);
  }
}
