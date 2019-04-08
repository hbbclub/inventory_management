import 'package:annotation_route/route.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/inventory_page/page.dart' as inventory;

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

const routerNameForScannerPage = 'router://ScannerPage';

@ARoute(url: routerNameForScannerPage)
class ScannerPage extends Page<ScannerState, inventory.InventoryState> {
  ScannerPage(parpams)
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ScannerState>(
              adapter: null, slots: <String, Dependent<ScannerState>>{}),
          middleware: <Middleware<ScannerState>>[],
        );
}
