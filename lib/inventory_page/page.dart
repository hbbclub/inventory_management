import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
export  'state.dart';
import 'view.dart';

const routerNameForInventoryPage = 'router://InventoryPage';
class InventoryPage extends Page<InventoryState, Map<String, dynamic>> {
  InventoryPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<InventoryState>(
                adapter: null,
                slots: <String, Dependent<InventoryState>>{
                }),
            middleware: <Middleware<InventoryState>>[
            ],);

}
