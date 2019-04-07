import 'package:fish_redux/fish_redux.dart';

enum ResetPasswordAction { onSave }

class ResetPasswordActionCreator {
  static Action onSave() {
    return const Action(ResetPasswordAction.onSave);
  }
}
