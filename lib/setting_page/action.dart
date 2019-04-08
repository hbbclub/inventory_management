import 'package:fish_redux/fish_redux.dart';

enum SettingAction {
  onJumpToResetPassword,
  onClearCache,
  onSignOut,
  onServerManagerment
}

class SettingActionCreator {
  static Action onJumpToResetPassword() {
    return const Action(SettingAction.onJumpToResetPassword);
  }

  static Action onClearCache() {
    return const Action(SettingAction.onClearCache);
  }

  static Action onSignOut() {
    return const Action(SettingAction.onSignOut);
  }

  static Action onServerManagerment() {
    return const Action(SettingAction.onServerManagerment);
  }
}
