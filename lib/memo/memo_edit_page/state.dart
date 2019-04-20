import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_edit_page/memo_notes_component/state.dart';
import 'package:inventory_management/memo/memo_list_page/memo_list_tile_component/state.dart';
import 'package:inventory_management/route/app_state.dart';

enum NotePageType {
  Edit,
  Add,
}

class MemoEditState implements Cloneable<MemoEditState> {
  List<dynamic> images = [];
  MemoListTileState listTileState = MemoListTileState();

  @override
  MemoEditState clone() {
    return MemoEditState()
      ..listTileState = listTileState.clone()
      ..images = images;
    // ..textEditingController = textEditingController;
  }
}

MemoEditState initState(MemoListTileState args) {
  List images = [MemoNotesState()..textEditingController.text = args.notes];
  images.addAll(args.files ?? []);
 
  return MemoEditState()
    // ..textEditingController = TextEditingController(text: args.notes)
    ..listTileState = args.clone()
    ..images = images;
}



class MemoEditConnector extends ConnOp<AppState, MemoEditState> {
  @override
  MemoEditState get(AppState appState) {
    final MemoEditState state = appState.memoEditState.clone();
    return state;
  }

  @override
  void set(AppState appState, MemoEditState subState) {

    appState.memoEditState = subState.clone();
  }
}