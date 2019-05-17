import 'package:barcode_scan/barcode_scan.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/agent/api.dart';
import 'package:inventory_management/material/material_detail_page/page.dart';
import 'package:inventory_management/material/model/material_model.dart';
import 'package:inventory_management/printing/stk_label_page/page.dart';
import 'package:inventory_management/route/router.dart';
import 'action.dart';
import 'state.dart';

Effect<MaterialListState> buildEffect() {
  return combineEffects(<Object, Effect<MaterialListState>>{
    Lifecycle.initState: _onInit,
    MaterialListAction.onSearch: _onSearch,
    MaterialListAction.onLoadmore: _onLoadmore,
    MaterialListAction.onEnterDetail: _onEnterDetail,
    MaterialListAction.onClearSearch: _onClearSearch,
    MaterialListAction.onBack: _onBack,
    MaterialListAction.onScan: _onScan,
  });
}

void _onInit(Action action, Context<MaterialListState> ctx) async {
  ApiModel result = await api.materialList();
  if (result.isError()) {
    return;
  }
  List labels = result.data['data'] ?? [];
  List<MaterialModel> res = [];
  for (Map item in labels) {
    res.add(MaterialModel.fromJson(item));
  }
  ctx.dispatch(MaterialListActionCreator.init(res.reversed.toList()));
}

void _onEnterDetail(Action action, Context<MaterialListState> ctx) async {
  MaterialModel model = action.payload;
  if (ctx.state.type == MaterialListType.page) {
    appRouter.pushScreen(ctx.context, routerNameForMaterialDetailPage,
        arguments: model);
  } else {
    appRouter.pushScreen(ctx.context, routerNameForStkLabelPage,
        arguments: model);
  }
}

void _onClearSearch(Action action, Context<MaterialListState> ctx) async {
  await ctx.dispatch(MaterialListActionCreator.clearSearch());
  await ctx.dispatch(MaterialListActionCreator.onSearch(''));
}

void _onBack(Action action, Context<MaterialListState> ctx) async {
  appRouter.popScreen(ctx.context);
}

void _onScan(Action action, Context<MaterialListState> ctx) async {
  try {
    String barcode = await BarcodeScanner.scan();
    if (barcode.length > 1) {
      String text = barcode.substring(1, barcode.length);
      ctx.dispatch(MaterialListActionCreator.scaned(text));
    }
  } catch (e) {}
}

Future<Null> _onLoadmore(Action action, Context<MaterialListState> ctx) async {
  int current = action.payload;
  ApiModel result = await api.materialList(
      current: current, keyword: ctx.state.keywordController.text);
  if (result.isError()) {
    return;
  }
  List labels = result.data['data'] ?? [];
  List<MaterialModel> res = [];
  for (Map item in labels) {
    res.add(MaterialModel.fromJson(item));
  }
  List<MaterialModel> datas = List.from(ctx.state.list);
  datas.addAll(res.reversed.toList());
  ctx.dispatch(MaterialListActionCreator.init(datas));
  return;
}

void _onSearch(Action action, Context<MaterialListState> ctx) async {
  String keyword = action.payload;
  ApiModel result = await api.materialList(keyword: keyword);
  if (result.isError()) {
    return;
  }
  List labels = result.data['data'] ?? [];
  List<MaterialModel> res = [];
  for (Map item in labels) {
    res.add(MaterialModel.fromJson(item));
  }
  ctx.dispatch(MaterialListActionCreator.init(res.reversed.toList()));
}

// void _onInit(Action action, Context<MaterialListState> ctx) async {
//   //TODO
//   //magic ~ :)
//   //too little time to finish the thing .
//   //reasonable way maybe with a custom search list
//   //let’s do this now~~~ ohhhh
//   await Future.delayed(Duration(milliseconds: 1000));
//   await showSearch(
//     delegate: SearchMaterial(ctx),
//     context: ctx.context,
//   );
//   appRouter.popScreen(ctx.context);
// }
