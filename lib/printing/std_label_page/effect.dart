import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:inventory_management/agent/api.dart';
import 'package:inventory_management/printing/std_label_page/std_component/state.dart';
import 'package:printer/printer.dart';
import 'action.dart';
import 'state.dart';

Effect<StdLabelState> buildEffect() {
  return combineEffects(<Object, Effect<StdLabelState>>{
    Lifecycle.initState: _onInit,
    StdLabelAction.onPrinterStd: _onPrinterStd,
  });
}

void _onInit(Action action, Context<StdLabelState> ctx) async {
  ApiModel result = await api.labelList();
  if (result.error != 0) {
    return;
  }
  //解析数据
  List labels = result.data['data'] ?? [];
  List<StdState> res = [];
  for (Map item in labels) {
    res.add(StdState.fromJson(item));
  }

  ctx.dispatch(StdLabelActionCreator.init(res));
}

void _onPrinterStd(Action action, Context<StdLabelState> ctx) async {
  Map<String, dynamic> args = {};
  List<Map<String, dynamic>> data = ctx.state.labels
      .where((item) => int.parse(item.textController.text) > 0)
      .map((item) {
    Map<String, dynamic> itemMap = item.toJson();
    itemMap['count'] = int.parse(item.textController.text);
    itemMap['url'] = item.imgs.first.url;
    return itemMap;
  }).toList();
  for (var item in data) {
    item['imageData'] = await DiskCache().load(item['url'].hashCode.toString());
  }
  args['type'] = 'std';
  args['data'] = data;
  print(args);
  Printer.print(args);
}
