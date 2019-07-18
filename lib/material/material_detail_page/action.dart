import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/material/model/material_model.dart';

enum MaterialDetailAction {
  init,
  pageChanged,
  onSelectImage,
  selectdImage,
  jumpToStkPrint,
  initModel,
}

class MaterialDetailActionCreator {
  static Action init(Map<String, dynamic> args) {
    return Action(MaterialDetailAction.init, payload: args);
  }

  static Action initModel(MaterialModel model) {
    return Action(MaterialDetailAction.initModel, payload: model);
  }

  static Action pageChanged(Map<String, dynamic> args) {
    return Action(MaterialDetailAction.init, payload: args);
  }

  static Action onSelectImage() {
    return Action(
      MaterialDetailAction.onSelectImage,
    );
  }

  static Action selectdImage(image) {
    return Action(MaterialDetailAction.selectdImage, payload: image);
  }

  static Action jumpToStkPrint() {
    return Action(MaterialDetailAction.jumpToStkPrint);
  }
}
