import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/login_page/model/user_model.dart';
import 'package:printer/printer.dart';
import 'package:inventory_management/welcome_page/model/cache_model.dart';
import 'action.dart';
import 'state.dart';

Effect<StkLabelState> buildEffect() {
  return combineEffects(<Object, Effect<StkLabelState>>{
    StkLabelAction.onPrinterStk: _onPrinterStk,
  });
}

void _onPrinterStk(Action action, Context<StkLabelState> ctx) {
  Initial initials = cacheModel.user.initials;
  Map<String, dynamic> args = {};
  Map<String, dynamic> info = ctx.state.model.toJson();
  info.addAll({'count': int.parse(ctx.state.countController.text ?? '0')});
  info.addAll({
    'lot': initials.lot + (ctx.state.lotNumberController.text ?? '0').toString()
  });
  info['part_no'] = initials.part + (info['part_no'] ?? '').toString();
  info['loc'] = initials.loc + (info['loc'] ?? '').toString();
  info['sap_qty'] = (info['sap_qty'] ?? '0').toString();
  args['type'] = 'stk';
  args['data'] = info;
  Printer.print(args);
}
