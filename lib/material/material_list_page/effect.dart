import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/material/searchDelegate/search_material.dart';
import 'package:inventory_management/route/route.route.dart';
import 'action.dart';
import 'state.dart';

Effect<MaterialListState> buildEffect() {
  return combineEffects(<Object, Effect<MaterialListState>>{
    Lifecycle.initState: _onInit,
  });
}

void _onInit(Action action, Context<MaterialListState> ctx) async {
  //magic ~ :)
  //too little time to finish the thing .
  //reasonable way maybe with a custom search list
  //let’s do this now~~~ ohhhh
  await Future.delayed(Duration(milliseconds: 1000));
  await showSearch(
    delegate: SearchMaterial(ctx),
    context: ctx.context,
  );
  router.popScreen(ctx.context);
}
