import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MemoListTileComponent extends Component<MemoListTileState> {
  MemoListTileComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<MemoListTileState>(
                adapter: null,
                slots: <String, Dependent<MemoListTileState>>{
                }),);

}
