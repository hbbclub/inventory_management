import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/common/utils.dart';
import 'package:inventory_management/memo/memo_edit_page/memo_edit_adapter/action.dart';

import 'package:inventory_management/memo/memo_edit_page/memo_image_component/state.dart';
import 'package:inventory_management/memo/memo_edit_page/memo_notes_component/state.dart';
import 'package:inventory_management/memo/memo_edit_page/ocr_list_page/page.dart';
import 'package:inventory_management/memo/memo_save_page/page.dart';
import 'package:inventory_management/route/route.route.dart';
import 'package:inventory_management/route/router.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'action.dart';
import 'state.dart';
import 'package:flutter/services.dart';

Effect<MemoEditState> buildEffect() {
  return combineEffects(<Object, Effect<MemoEditState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _dispose,
    MemoEditPageAction.onLoadAssets: _onLoadAssets,
    MemoEditPageAction.onOcr: _onOcr,
    MemoEditPageAction.onSave: _onSave,
  });
}

void _dispose(Action action, Context<MemoEditState> ctx) async {
  for (var image in ctx.state.images) {
    if (image is MemoImageState && image.asset != null) {
      image.asset.release();
    }
  }
}

void _onInit(Action action, Context<MemoEditState> ctx) async {
  for (var image in ctx.state.images) {
    if (image is MemoImageState && image.asset != null) {
      await image.asset.requestThumbnail(300, 300, quality: 50);
    }
  }
}

void _onOcr(Action action, Context<MemoEditState> ctx) async {
  String result =
      await appRouter.pushScreen(ctx.context, routerNameForOcrListPage);
  if (result != null) {
    ctx.dispatch(MemoEditPageActionCreator.didOcr(result));
  }
}

void _onSave(Action action, Context<MemoEditState> ctx) async {
  MemoNotesState textState = ctx.state.images[0];
  appRouter.pushScreen(
    ctx.context,
    routerNameForMemoSavePage,
    arguments: {
      'notes': textState.textEditingController.text,
      'images': ctx.state.images.getRange(1, ctx.state.images.length).toList(),
      'tileState': ctx.state.listTileState,
    },
  );
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
    List<MemoImageState> images = List.generate(resultList.length, (int index) {
      return MemoImageState(
          id: Utils.currentTimeMillisAccumulation(index).toString(),
          asset: resultList[index]);
    });
    for (MemoImageState image in images) {
      await image.asset.requestThumbnail(300, 300, quality: 50);
    }
    ctx.dispatch(MemoEditActionCreator.loadAssets(images ?? []));
  }
}
