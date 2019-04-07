import 'package:annotation_route/route.dart';
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

const routerNameForResetPasswordPage = 'router://ResetPasswordPage';

@ARoute(url: routerNameForResetPasswordPage)
class ResetPasswordPage extends Page<ResetPasswordState, Map<String, dynamic>> {
  ResetPasswordPage(param)
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ResetPasswordState>(
              adapter: null, slots: <String, Dependent<ResetPasswordState>>{}),
          middleware: <Middleware<ResetPasswordState>>[],
        );
}
