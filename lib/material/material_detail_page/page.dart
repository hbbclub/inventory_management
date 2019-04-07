import 'package:annotation_route/route.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/material/material_detail_page/advanced_component/component.dart';
import 'package:inventory_management/material/material_detail_page/info_component/component.dart';
import 'package:inventory_management/material/material_detail_page/stock_component/component.dart';
import 'package:inventory_management/material/model/material_model.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TickerComponentState extends ComponentState<MaterialDetailState>
    with SingleTickerProviderStateMixin {}

const routerNameForMaterialDetailPage = 'router://MaterialDetailPage';

@ARoute(url: routerNameForMaterialDetailPage)
class MaterialDetailPage extends Page<MaterialDetailState, MaterialModel> {
  @override
  TickerComponentState createState() => TickerComponentState();

  MaterialDetailPage(param)
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MaterialDetailState>(
              adapter: null,
              slots: <String, Dependent<MaterialDetailState>>{
                'info': InfoConnector() + InfoComponent(),
                'stock': StockConnector() + StockComponent(),
                'advanced': AdvancedConnector() + AdvancedComponent()
              }),
          middleware: <Middleware<MaterialDetailState>>[],
        );
}
