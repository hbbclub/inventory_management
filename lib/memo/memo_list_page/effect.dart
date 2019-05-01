import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/agent/api.dart';
import 'package:inventory_management/memo/memo_edit_page/page.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/action.dart'
    as listTileAction;
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/state.dart';
import 'package:inventory_management/route/router.dart';
import 'action.dart';
import 'state.dart';

Effect<MemoListState> buildEffect() {
  return combineEffects(<Object, Effect<MemoListState>>{
    Lifecycle.initState: _onInit,
    listTileAction.MemoListTileAction.onEdit: _onEdit,
    MemoPageAction.onSearch: _onSearch,
    MemoPageAction.onLoadmore: _onLoadmore,
  });
}

void _onInit(Action action, Context<MemoListState> ctx) async {
  ApiModel result = await api.noteList();
  if (result.isError()) {
    return;
  }
  List labels = result.data['data'] ?? [];
  List<MemoListTileState> res = [];
  for (Map item in labels) {
    res.add(MemoListTileState.fromJson(item));
  }
  ctx.dispatch(MemoPageActionCreator.init(res.reversed.toList()));
}

Future<Null> _onLoadmore(Action action, Context<MemoListState> ctx) async {
  int current = action.payload;
  ApiModel result = await api.noteList(current: current);
  if (result.isError()) {
    return ;
  }
  List labels = result.data['data'] ?? [];
  List<MemoListTileState> res = [];
  for (Map item in labels) {
    res.add(MemoListTileState.fromJson(item));
  }
  List<MemoListTileState> datas = List.from(ctx.state.list);
  datas.addAll(res.reversed.toList());
  ctx.dispatch(MemoPageActionCreator.init(datas));
  return ;
}

void _onEdit(Action action, Context<MemoListState> ctx) async {
  MemoListTileState state = action.payload;

  await appRouter.pushScreen(ctx.context, routerNameForMemoEditPage,
      arguments: state);
  _onInit(action, ctx);
}

void _onSearch(Action action, Context<MemoListState> ctx) async {
  String keyword = action.payload;
  ApiModel result = await api.noteList(keyword: keyword);
  if (result.isError()) {
    return;
  }
  List labels = result.data['data'] ?? [];
  List<MemoListTileState> res = [];
  for (Map item in labels) {
    res.add(MemoListTileState.fromJson(item));
  }
  ctx.dispatch(MemoPageActionCreator.init(res.reversed.toList()));
}
