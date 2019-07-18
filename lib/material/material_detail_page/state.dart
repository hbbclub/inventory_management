import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/material/material_detail_page/advanced_component/state.dart';
import 'package:inventory_management/material/material_detail_page/info_component/state.dart';
import 'package:inventory_management/material/material_detail_page/stock_component/state.dart';
import 'package:inventory_management/material/model/material_model.dart';
import 'package:inventory_management/route/app_state.dart';

class MaterialDetailState implements Cloneable<MaterialDetailState> {
  TextEditingController controller =
      TextEditingController.fromValue(TextEditingValue.empty);
  MaterialModel model;
  String partNo;
  String barcode = '';
  var isPageCanChanged = true;
  TabController mTabController;
  PageController mPageController = PageController(initialPage: 0);

  @override
  MaterialDetailState clone() {
    return MaterialDetailState()
      ..controller = controller
      ..model = model
      ..partNo = partNo
      ..barcode = barcode
      ..isPageCanChanged = isPageCanChanged
      ..mTabController = mTabController
      ..mPageController = mPageController;
  }
}

MaterialDetailState initState(MaterialModel args) {
  return MaterialDetailState()..partNo = args.partNo;
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(
    title: 'Info',
    icon: Icons.label,
  ),
  const Choice(title: 'Stocks', icon: Icons.scanner),
  const Choice(title: 'Advanced', icon: Icons.scanner),
];

class MaterialDetailConnector extends ConnOp<AppState, MaterialDetailState> {
  @override
  MaterialDetailState get(AppState appState) {
    final MaterialDetailState state = appState.materialDetailState.clone();
    return state;
  }

  @override
  void set(AppState appState, MaterialDetailState subState) {
    appState.materialDetailState = subState.clone();
  }
}

class InfoConnector extends ConnOp<MaterialDetailState, InfoState> {
  @override
  InfoState get(MaterialDetailState state) {
    final InfoState infoState = InfoState();
    infoState.model = state.model;
    return infoState;
  }

  @override
  void set(MaterialDetailState state, InfoState subState) {}
}

class StockConnector extends ConnOp<MaterialDetailState, StockState> {
  @override
  StockState get(MaterialDetailState state) {
    final StockState stockState = StockState();
    stockState.model = state.model;
    return stockState;
  }

  @override
  void set(MaterialDetailState state, StockState subState) {
    state.model = subState.model;
  }
}

class AdvancedConnector extends ConnOp<MaterialDetailState, AdvancedState> {
  @override
  AdvancedState get(MaterialDetailState state) {
    final AdvancedState acvancedState = AdvancedState();
    acvancedState.model = state.model;
    return acvancedState;
  }

  @override
  void set(MaterialDetailState state, AdvancedState subState) {}
}
