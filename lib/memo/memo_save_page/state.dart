import 'package:fish_redux/fish_redux.dart';

class MemoSaveState implements Cloneable<MemoSaveState> {

  @override
  MemoSaveState clone() {
    return MemoSaveState();
  }
}

MemoSaveState initState(Map<String, dynamic> args) {
  return MemoSaveState();
}
