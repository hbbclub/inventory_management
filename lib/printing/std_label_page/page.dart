import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/printing/std_label_page/std_adapter/adapter.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

const routerNameForStdLabelPage = 'router://StdLabelPage';
class StdLabelPage extends Page<StdLabelState, Map<String, dynamic>> {
  StdLabelPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<StdLabelState>(
                adapter: StdAdapter(),
                slots: <String, Dependent<StdLabelState>>{
                }),
            middleware: <Middleware<StdLabelState>>[
            ],);

}
