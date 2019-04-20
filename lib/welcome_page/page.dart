import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

const routerNameForWelcomePage = 'router://WelcomePage';

class WelcomePage extends Page<WelcomeState, Map<String, dynamic>> {
  WelcomePage()
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
