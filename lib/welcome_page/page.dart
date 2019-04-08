import 'package:annotation_route/route.dart';
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

const routerNameForWelcomePage = 'router://WelcomePage';

@ARoute(url: routerNameForWelcomePage)
class WelcomePage extends Page<WelcomeState, Map<String, dynamic>> {
  WelcomePage(param)
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<WelcomeState>(
              adapter: null, slots: <String, Dependent<WelcomeState>>{}),
          middleware: <Middleware<WelcomeState>>[],
        );
}
