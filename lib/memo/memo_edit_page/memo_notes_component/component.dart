import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MemoNotesComponent extends Component<MemoNotesState> {
  MemoNotesComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<MemoNotesState>(
                adapter: null,
                slots: <String, Dependent<MemoNotesState>>{
                }),);

}
