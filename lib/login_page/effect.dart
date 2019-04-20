import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/route/router.dart';
import 'package:inventory_management/tab_page/page.dart';
import 'package:inventory_management/agent/agent.dart';
import 'package:inventory_management/agent/api.dart';
import 'package:inventory_management/common/utils.dart';
import 'package:inventory_management/login_page/model/user_model.dart';
import 'package:inventory_management/welcome_page/model/cache_model.dart';

import 'action.dart';
import 'state.dart';

Effect<LoginState> buildEffect() {
  return combineEffects(<Object, Effect<LoginState>>{
    LoginAction.onLogin: _onLogin,
    Lifecycle.initState: _onInit,
  });
}

void _onInit(Action action, Context<LoginState> ctx) async {
  if (ctx.state.account.text.isNotEmpty &&
      ctx.state.password.text.isNotEmpty &&
      ctx.state.linkWord.text.isNotEmpty &&
      ctx.state.hostUrl.text.isNotEmpty) {
    ctx.dispatch(LoginActionCreator.changeCanLogin(true));
  }
}

void _onLogin(Action action, Context<LoginState> ctx) async {
  httpUtil.changeHostUrl('http://' + ctx.state.hostUrl.text);

  cacheModel.account = ctx.state.account.text;
  cacheModel.password = ctx.state.password.text;
  cacheModel.hostUrl = ctx.state.hostUrl.text;
  cacheModel.linkword = ctx.state.linkWord.text;

  cacheModel.setLoaclCache();

  ApiModel result = await api.login(
      username: ctx.state.account.text,
      password: ctx.state.password.text,
      linkWord: ctx.state.linkWord.text);
  if (result.isError()) {
    Utils.showSnackBarWithKey(ctx.state.scaffoldkey,
        text: result.data['message']);
    return;
  }
  cacheModel.user = UserModel.fromJson(result.data['user']);
  cacheModel.setLoaclCache();
  httpUtil.commonHeader.addAll({
    'Authorization': result.data['token'],
  });
  appRouter.replaceScreen(
    ctx.context,
    routerNameForTabPage,
  );
}
