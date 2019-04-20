import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_edit_page/ocr_list_page/ocr_adapter/adapter.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

const routerNameForOcrListPage = 'router://OcrListPage';

class OcrListPage extends Page<OcrListState, Map<String, dynamic>> {
  OcrListPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<OcrListState>(
              adapter: OcrAdapter(),
              slots: <String, Dependent<OcrListState>>{}),
          middleware: <Middleware<OcrListState>>[],
        );
}
