import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/material/model/material_model.dart';

class InfoState implements Cloneable<InfoState> {
  MaterialModel model = MaterialModel();
  @override
  InfoState clone() {
    return InfoState()..model = model;
  }
}

InfoState initState(Map<String, dynamic> args) {
  return InfoState();
}
