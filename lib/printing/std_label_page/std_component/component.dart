import 'package:fish_redux/fish_redux.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class StdComponent extends Component<StdState> with PrivateReducerMixin<StdState>  {
  StdComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<StdState>(
                adapter: null,
                slots: <String, Dependent<StdState>>{
                }),);

}
