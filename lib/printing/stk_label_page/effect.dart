import 'package:fish_redux/fish_redux.dart';
import 'package:printer/printer.dart';
import 'action.dart';
import 'state.dart';

Effect<StkLabelState> buildEffect() {
  return combineEffects(<Object, Effect<StkLabelState>>{
    StkLabelAction.onPrinterStk: _onPrinterStk,
  });
}

void _onPrinterStk(Action action, Context<StkLabelState> ctx) {
  Map<String, dynamic> args = {};
  Map<String, dynamic> info = ctx.state.model.toJson();
  info.addAll({'count': int.parse(ctx.state.countController.text)});
  args['type'] = 'stk';
  args['data'] = info;
  Printer.print(args);
}
