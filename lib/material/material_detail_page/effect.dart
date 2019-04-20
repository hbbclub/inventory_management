import 'package:analyzer/file_system/file_system.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventory_management/printing/stk_label_page/page.dart';
import 'package:inventory_management/route/route.route.dart';
import 'package:inventory_management/route/router.dart';
import 'action.dart';
import 'state.dart';

Effect<MaterialDetailState> buildEffect() {
  return combineEffects(<Object, Effect<MaterialDetailState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _dispose,
    MaterialDetailAction.onSelectImage: _onSelectImage,
    MaterialDetailAction.jumpToStkPrint: _jumpToStkPrint,
  });
}

void _onInit(Action action, Context<MaterialDetailState> ctx) {
  TabController tab = TabController(
    length: choices.length,
    vsync: ctx.stfState as TickerProvider,
  );
  tab.addListener(() {
    //TabBar的监听
    if (tab.indexIsChanging) {
      //判断TabBar是否切换
      _onPageChange(ctx, tab.index, p: ctx.state.mPageController);
    }
  });
  ctx.dispatch(MaterialDetailActionCreator.init({'tab': tab}));
}

void _dispose(Action action, Context<MaterialDetailState> ctx) {
  ctx.state.controller.dispose();
}

void _jumpToStkPrint(Action action, Context<MaterialDetailState> ctx) {
  appRouter.pushScreen(ctx.context,routerNameForStkLabelPage);
}

void _onSelectImage(Action action, Context<MaterialDetailState> ctx) async {
  if (ctx.state.model.imgs?.length == 0) {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  }
}

_onPageChange(Context<MaterialDetailState> ctx, int index,
    {PageController p, TabController t}) async {
  if (p != null) {
    //判断是哪一个切换
    await ctx.state.mPageController.animateToPage(index,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease); //等待pageview切换完毕,再释放pageivew监听
  } else {
    ctx.state.mTabController.animateTo(index); //切换Tabbar
  }
}
