import 'package:annotation_route/route.dart';
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

const routerNameForSettingPage = 'router://SettingPage';

@ARoute(url: routerNameForSettingPage)
class SettingPage extends Page<SettingState, Map<String, dynamic>> {
  SettingPage(param)
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SettingState>(
              adapter: null, slots: <String, Dependent<SettingState>>{}),
          middleware: <Middleware<SettingState>>[],
        );
}
