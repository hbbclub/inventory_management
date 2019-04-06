import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/common/utils.dart';
import 'package:inventory_management/memo/memo_edit_page/memo_edit_adapter/action.dart';

import 'package:inventory_management/memo/memo_edit_page/memo_image_component/state.dart';
import 'package:inventory_management/memo/memo_edit_page/ocr_list_page/page.dart';
import 'package:inventory_management/route/route.route.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'action.dart';
import 'state.dart';
import 'package:flutter/services.dart';

Effect<MemoEditState> buildEffect() {
  return combineEffects(<Object, Effect<MemoEditState>>{
    Lifecycle.initState: _onInit,
    MemoEditPageAction.onLoadAssets: _onLoadAssets,
    MemoEditPageAction.onOcr: _onOcr,
  });
}

void _onInit(Action action, Context<MemoEditState> ctx) {}

void _onOcr(Action action, Context<MemoEditState> ctx) async {
  String result = await router.pushScreen(
      ctx.context, RouterPageOption(url: routerNameForOcrListPage));
  if (result != null) {
    ctx.dispatch(MemoEditPageActionCreator.didOcr(result));
  }
}

void _onLoadAssets(Action action, Context<MemoEditState> ctx) async {
  List<Asset> resultList = [];
  String error;
  try {
    resultList = await MultiImagePicker.pickImages(
      maxImages: 300,
      enableCamera: true,
    );
  } on PlatformException catch (e) {
    error = e.message;
  }
  if (error == null) {
    List<MemoImageState> states = List.generate(resultList.length, (int index) {
      return MemoImageState(
          id: Utils.currentTimeMillisAccumulation(index).toString(),
          asset: resultList[index]);
    });
    ctx.dispatch(MemoEditActionCreator.loadAssets(states ?? []));
  }
}
