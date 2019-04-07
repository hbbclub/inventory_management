import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AdvancedComponent extends Component<AdvancedState> {
  AdvancedComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<AdvancedState>(
                adapter: null,
                slots: <String, Dependent<AdvancedState>>{
                }),);

}
