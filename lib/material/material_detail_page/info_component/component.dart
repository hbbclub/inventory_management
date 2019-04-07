import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class InfoComponent extends Component<InfoState> {
  InfoComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<InfoState>(
                adapter: null,
                slots: <String, Dependent<InfoState>>{
                }),);

}
