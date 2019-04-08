import 'package:annotation_route/route.dart';
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

const routerNameForStkLabelPage = 'router://StkLabelPage';

@ARoute(url: routerNameForStkLabelPage)
class StkLabelPage extends Page<StkLabelState, Map<String, dynamic>> {
  StkLabelPage(param)
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<StkLabelState>(
              adapter: null, slots: <String, Dependent<StkLabelState>>{}),
          middleware: <Middleware<StkLabelState>>[],
        );
}
