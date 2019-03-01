import 'dart:async';
import 'package:inventory_management/bundles/agent/api_model.dart';
import 'package:dio/dio.dart';

final  BaseOptions options = BaseOptions(
  baseUrl: "http://aab04c21.ngrok.io/mm",
  connectTimeout: 5000,
  receiveTimeout: 8000,
  headers: <String, String>{
    'Cache-Control': 'no-cache',
  },
);

class Agent {
  static final Dio dio = new Dio(options);

  Future<ApiModel> post(
    String url, {
    Map<String, dynamic> params,
  }) async {
    try {
      Response res = await dio.post(url, data: params);
      return _handelResult(res, url);
    } catch (e) {
      return _handError(e.toString(), 1);
    }
  }

  Future<ApiModel> get(
    String url, {
    Map<String, dynamic> params,
  }) async {
    try {
      Response res = await dio.get(url, queryParameters: params);
      return _handelResult(res, url);
    } catch (e) {
      return _handError(e.toString(), 1);
    }
  }

  Future<ApiModel> _handelResult(Response res, String url) async {
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

  Future<ApiModel> get(
    String url, {
    Map<String, dynamic> params,
  }) async {
    return await agent.get(url, params: params);
  }
}

final httpUtil = HttpUtil();
