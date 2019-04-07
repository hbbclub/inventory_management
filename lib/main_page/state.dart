import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/common/images.dart';
import 'package:inventory_management/inventory_page/page.dart';
import 'package:inventory_management/material/material_list_page/page.dart';
import 'package:inventory_management/memo/memo_list_page/page.dart';
import 'package:inventory_management/printing/std_label_page/page.dart';

class MainModel {
  String iconPath;
  String routerName;
  String title;
  MainModel(
    this.iconPath,
    this.routerName,
    this.title,
  );
}

class MainState implements Cloneable<MainState> {
  List<MainModel> modules = [];
  @override
  MainState clone() {
    return MainState()..modules = modules;
  }
}

MainState initState(Map<String, dynamic> args) {
  return MainState()
    ..modules = [
      MainModel(ImageAssets.main1, routerNameForMaterialListPage, 'SKU Query'),
      MainModel(ImageAssets.main2, routerNameForStdLabelPage, 'Label Print'),
      MainModel(ImageAssets.main3, routerNameForMemoListPage, 'Note'),
      MainModel(ImageAssets.main4, routerNameForInventoryPage, 'Physical Inv')
    ];
}
