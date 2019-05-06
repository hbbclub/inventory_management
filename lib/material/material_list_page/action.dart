import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/material/model/material_model.dart';

enum MaterialListAction {
  init,
  onSearch,
  clearSearch,
  onClearSearch,
  onLoadmore,
  onEnterDetail,
  onBack
}

class MaterialListActionCreator {
  static Action init(List<MaterialModel> list) {
    return Action(MaterialListAction.init, payload: list);
  }

  static Action onSearch(String keyword) {
    return Action(MaterialListAction.onSearch, payload: keyword);
  }

  static Action onLoadmore(int current) {
    return Action(MaterialListAction.onLoadmore, payload: current);
  }

  static Action clearSearch() {
    return Action(MaterialListAction.clearSearch);
  }
  static Action onClearSearch() {
    return Action(MaterialListAction.onClearSearch);
  }

  static Action onEnterDetail(MaterialModel model) {
    return Action(MaterialListAction.onEnterDetail, payload: model);
  }

  static Action onBack() {
    return Action(MaterialListAction.onBack);
  }
}
