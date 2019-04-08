import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MemoImageComponent extends Component<MemoImageState> {
  MemoImageComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<MemoImageState>(
                adapter: null,
                slots: <String, Dependent<MemoImageState>>{
                }),);

}
