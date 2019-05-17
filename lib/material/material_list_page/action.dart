import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/material/model/material_model.dart';

enum MaterialListAction {
  init,
  onSearch,
  clearSearch,
  onClearSearch,
  onLoadmore,
  onEnterDetail,
  onScan,
  scaned,
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

  static Action onScan() {
    return Action(MaterialListAction.onScan);
  }

  static Action scaned(String text) {
    return Action(MaterialListAction.scaned, payload: text);
  }
}
