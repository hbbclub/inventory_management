import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/common/images.dart';

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
  return MainState()..modules=[
    MainModel(ImageAssets.main1,'','SKU Query'),
    MainModel(ImageAssets.main2,'','Label Print'),
    MainModel(ImageAssets.main3,'','Label Print'),
    MainModel(ImageAssets.main4,'','Physical Inv')
  ];
}
