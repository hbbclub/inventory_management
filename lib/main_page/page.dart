import 'package:annotation_route/route.dart';
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

const routerNameForMainPage = 'router://MainPage';
@ARoute(url: routerNameForMainPage)
class MainPage extends Page<MainState, Map<String, dynamic>> {
  MainPage(Map<String, dynamic> params)
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MainState>(
              adapter: null, slots: <String, Dependent<MainState>>{}),
          middleware: <Middleware<MainState>>[],
        );
}
