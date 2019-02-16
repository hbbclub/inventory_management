import 'dart:async';
import 'package:inventory_management/bundles/agent/api_model.dart';
import 'package:dio/dio.dart';

BaseOptions options = BaseOptions(
  baseUrl: "http://dev01.aiqin.com/scm-neo-rpc/aq_rpc",
  connectTimeout: 5000,
  receiveTimeout: 3000,
  headers: <String, String>{
    'Cache-Control': 'no-cache',
  },
);

class Agent {
  Dio dio = new Dio(options);

  Future<ApiModel> post(
    String url, {
    Map<String, dynamic> params,
  }) async {
    try {
      Response res = await dio.post(url, data: params);
      if (res.statusCode != 200) {
        //http请求异常
        return _handError(
            "code:" + res.statusCode.toString() + ' body:' + res.data,
            res.statusCode);
      }
      if (res.data == null || res.data == '') {
        //接口数据异常
        return _handError('数据返回为空 url:' + url, -1);
      }
      // final result = json.decode(res.data.toString());
      var model =
          ApiModel.fromJson({'error': 0, 'data': res.data, 'message': ''});
      return model;
    } catch (e) {
      return _handError(e.toString(), 1);
    }
  }

  Future<ApiModel> _handError(String errorMsg, int code) {
    print("errorMsg :" + errorMsg);
    var model =
        ApiModel.fromJson({'error': code, 'data': null, 'message': errorMsg});
    return Future.value(model);
  }
}

class HttpUtil {
  Agent agent = Agent();
  Future<ApiModel> post(
    String url, {
    Map<String, dynamic> params,
  }) async {
    return await agent.post(url, params: params);
  }
}

final httpUtil = HttpUtil();
