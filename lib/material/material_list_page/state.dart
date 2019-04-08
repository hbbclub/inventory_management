import 'package:fish_redux/fish_redux.dart';

class MaterialListState implements Cloneable<MaterialListState> {

  @override
  MaterialListState clone() {
    return MaterialListState();
  }
}

MaterialListState initState(Map<String, dynamic> args) {
  return MaterialListState();
}
