import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/tab_page/page.dart';
import 'package:inventory_management/agent/agent.dart';
import 'package:inventory_management/agent/api.dart';
import 'package:inventory_management/common/utils.dart';
import 'package:inventory_management/login_page/model/user_model.dart';
import 'package:inventory_management/route/route.route.dart';

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
  Utils.userName = ctx.state.account.text;
  Utils.password = ctx.state.password.text;
  Utils.hostUri = ctx.state.hostUrl.text;
  Utils.linkWord = ctx.state.linkWord.text;

  Utils.addLoaclCache({
    Utils.cacheKeyForHostUrl: ctx.state.hostUrl.text,
    Utils.cacheKeyForLinkWord: ctx.state.linkWord.text,
    Utils.cacheKeyForPassword: ctx.state.password.text,
    Utils.cacheKeyForUsername: ctx.state.account.text,
  });
  ApiModel result = await api.login(
      username: ctx.state.account.text,
      password: ctx.state.password.text,
      linkWord: ctx.state.linkWord.text);
  if (result.isError()) {
    Utils.showSnackBarWithKey(ctx.state.scaffoldkey,
        text: result.data['message']);
    return;
  }
  Utils.user = UserModel.fromJson(result.data['user']);
  httpUtil.commonHeader.addAll({
    'Authorization': result.data['token'],
  });
  router.pushScreen(ctx.context, RouterPageOption(url: routerNameForTabPage));
  // Utils.pushScreen(ctx.context, Tab());
}
