import 'package:flutter/material.dart';
import 'package:inventory_management/bundles/agent/agent.dart';
import 'package:inventory_management/bundles/common/utils.dart';
import 'package:flutter_user_agent/flutter_user_agent.dart';
import 'package:inventory_management/bundles/login/login_page.dart';
import 'package:package_info/package_info.dart';

class Welcome extends StatelessWidget {
  Future<void> initUserAgentState() async {
    String userAgent, hostUri, linkWord;
    try {
      //获取userAgent 添加到请求代理类中
      userAgent = await FlutterUserAgent.getPropertyAsync('userAgent');
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      Utils.appVersion = packageInfo.version;
      httpUtil.commonHeader.addAll({'User-Agent': userAgent});
      //拿到缓存对象 设置对应的hostUri 和linkWord
      Map<String, dynamic> localCache = await Utils.getLoaclCache();
      hostUri =
          Utils.hostUri = localCache[Utils.cacheKeyForHostUrl] ?? Utils.hostUri;
      linkWord = Utils.linkWord = localCache[Utils.cacheKeyForLinkWord] ?? '';
      Utils.userName = localCache[Utils.cacheKeyForUsername] ?? '';
      Utils.password = localCache[Utils.cacheKeyForPassword] ?? '';
    } on Exception {
      // userAgent = webViewUserAgent = '<error>';
    }
  }

  @override
  Widget build(BuildContext context) {
    initUserAgentState().then((data) {
      Utils.replaceScreen(context, LoginPage());
    });
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(' '),
        ),
      ),
    );
  }
}
