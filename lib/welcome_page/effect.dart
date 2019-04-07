import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_user_agent/flutter_user_agent.dart';
import 'package:inventory_management/agent/agent.dart';
import 'package:inventory_management/common/utils.dart';
import 'package:inventory_management/login_page/page.dart';
import 'package:inventory_management/route/route.route.dart';
import 'package:inventory_management/welcome_page/model/cache_model.dart';
import 'action.dart';
import 'state.dart';

Effect<WelcomeState> buildEffect() {
  return combineEffects(<Object, Effect<WelcomeState>>{
    Lifecycle.initState: _onInit,
  });
}

void _onInit(Action action, Context<WelcomeState> ctx) async {
  await initUserAgentState()
      .timeout(Duration(seconds: 3), onTimeout: () => Future.value());
  initScreenUtil(ctx.context);

  router.replaceScreen(
      ctx.context,
      RouterPageOption(url: routerNameForLoginPage, params: {
        'account': cacheModel.account,
        'password': cacheModel.password,
        'hostUri': cacheModel.hostUrl,
        'linkWord': cacheModel.linkword,
      }));
}

Future<void> initUserAgentState() async {
  String userAgent;
  try {
    cacheModel = await CacheModel.readLoaclCache();

    Utils.appVersion = await Utils.getAppVersion();
    //获取userAgent 添加到请求代理类中
    userAgent = await FlutterUserAgent.getPropertyAsync('userAgent');
    httpUtil.commonHeader.addAll({'User-Agent': userAgent});
    //拿到缓存对象 设置对应的hostUri 和linkWord
  } on Exception {
    // userAgent = webViewUserAgent = '<error>';
  }
}
