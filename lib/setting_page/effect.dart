import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/common/utils.dart';
import 'package:inventory_management/route/route.route.dart';
import 'package:inventory_management/route/router.dart';
import 'package:inventory_management/setting_page/reset_password_page/page.dart';
import 'action.dart';
import 'state.dart';

Effect<SettingState> buildEffect() {
  return combineEffects(<Object, Effect<SettingState>>{
    SettingAction.onJumpToResetPassword: _onJumpToResetPassword,
    SettingAction.onSignOut: _onSignOut,
    SettingAction.onClearCache: _onClearCache,
    SettingAction.onServerManagerment: _onServerManagerment,
  });
}

void _onJumpToResetPassword(Action action, Context<SettingState> ctx) {
  appRouter.pushScreen(
      ctx.context, routerNameForResetPasswordPage);
}

void _onClearCache(Action action, Context<SettingState> ctx) {
  Utils.showSnackBar(ctx.context, text: 'Cache has been cleaned.');
}

void _onServerManagerment(Action action, Context<SettingState> ctx) {
  // Utils.showSnackBar(ctx.context, text: 'Cache has been cleaned.');
}

void _onSignOut(Action action, Context<SettingState> ctx) {
  showDialog(
      context: ctx.context,
      builder: (_) {
        return AlertDialog(
          title: Text("Confirm sign out?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(ctx.context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Sign out"),
              onPressed: () {
                Navigator.of(ctx.context).pop();
              },
            ),
          ],
        );
      });
}
