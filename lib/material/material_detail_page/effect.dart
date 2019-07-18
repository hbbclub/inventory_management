import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/agent/api.dart';
import 'package:inventory_management/material/model/material_model.dart';
import 'package:inventory_management/printing/stk_label_page/page.dart';
import 'package:inventory_management/route/router.dart';
import 'package:multi_image_picker/asset.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/services.dart';
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

void _onInit(Action action, Context<MaterialDetailState> ctx) async {
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
  ApiModel result = await api.materialDetail(partNo: ctx.state.partNo);
  if (result.isError()) {
    return;
  }
  MaterialModel model = MaterialModel.fromJson(result.data['data']);

  ctx.dispatch(MaterialDetailActionCreator.initModel(model));
}

void _dispose(Action action, Context<MaterialDetailState> ctx) {
  ctx.state.controller.dispose();
}

void _jumpToStkPrint(Action action, Context<MaterialDetailState> ctx) {
  appRouter.pushScreen(ctx.context, routerNameForStkLabelPage,
      arguments: ctx.state.model);
}

void _onSelectImage(Action action, Context<MaterialDetailState> ctx) async {
  // if (ctx.state.model.imgs?.length == 0) {
  // File image = await ImagePicker.pickImage(source: ImageSource.gallery);
  List<Asset> resultList = [];
  String error;
  try {
    resultList = await MultiImagePicker.pickImages(
      maxImages: 1,
      enableCamera: true,
    );
    if (resultList.length == 0) {
      return;
    }
    ApiModel resule =
        await api.materialPhoto(resultList.first, ctx.state.model.partNo);
    if (resule.isError()) {
      return;
    }
    ApiModel result = await api.materialDetail(partNo: ctx.state.partNo);
    if (result.isError()) {
      return;
    }
    MaterialModel model = MaterialModel.fromJson(result.data['data']);
    ctx.dispatch(MaterialDetailActionCreator.initModel(model));
  } on PlatformException catch (e) {
    error = e.message;
  }
  if (error == null) {}
  // }
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
