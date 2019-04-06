import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class OcrLabelComponent extends Component<OcrLabelState>
    with PrivateReducerMixin {
  OcrLabelComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<OcrLabelState>(
              adapter: null, slots: <String, Dependent<OcrLabelState>>{}),
        );
}
