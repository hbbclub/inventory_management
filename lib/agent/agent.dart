import 'dart:async';
import 'package:inventory_management/agent/api_model.dart';
import 'package:dio/dio.dart';
import 'package:inventory_management/welcome_page/model/cache_model.dart';

enum HttpVerb { POST, GET, DELETE, PUT, PATCH }

final BaseOptions options = BaseOptions(
  baseUrl: 'http://' + cacheModel.hostUrl,
  connectTimeout: 5000,
  receiveTimeout: 8000,
  headers: <String, String>{
    'Cache-Control': 'no-cache',
    'Content-Type': 'application/json',
  },
);

class Agent {
  static Dio dio = new Dio(options);
  void changeHostUrl(String hostUrl) {
    dio.options.baseUrl = hostUrl;
  }

  Future<ApiModel> request(
    HttpVerb verb,
    String url, {
    Map<String, dynamic> params,
    Map<String, dynamic> header,
  }) async {
    try {
      print('url:' + dio.options.baseUrl + url);
      print(params);
      Response res;

      if (verb == HttpVerb.POST) {
        res = await dio.post(
          url,
          data: params,
          options: Options(headers: header),
        );
      } else if (verb == HttpVerb.GET) {
        res = await dio.get(
          url,
          queryParameters: params,
          options: Options(headers: header),
        );
      } else if (verb == HttpVerb.PUT) {
        res = await dio.put(
          url,
          data: params,
          options: Options(headers: header),
        );
      } else if (verb == HttpVerb.DELETE) {
        res = await dio.delete(
          url,
          data: params,
          options: Options(headers: header),
        );
      } else if (verb == HttpVerb.PATCH) {
        res = await dio.patch(
          url,
          data: params,
          options: Options(headers: header),
        );
      }

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
    print('result:' + dio.options.baseUrl + url);
    print(res.data);
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
  //私有构造方法
  HttpUtil._internal();

  //保存单例
  static HttpUtil _singleton = HttpUtil._internal();

  //工厂方法
  factory HttpUtil() => _singleton;

  Map<String, dynamic> commonHeader = {};

  Agent agent = Agent();
  Future<ApiModel> post(
    String url, {
    Map<String, dynamic> params,
  }) async {
    return await agent.request(
      HttpVerb.POST,
      url,
      params: params,
      header: commonHeader,
    );
  }

  Future<ApiModel> get(
    String url, {
    Map<String, dynamic> params,
  }) async {
    return await agent.request(
      HttpVerb.GET,
      url,
      params: params,
      header: commonHeader,
    );
  }

  Future<ApiModel> patch(
    String url, {
    Map<String, dynamic> params,
  }) async {
    return await agent.request(
      HttpVerb.PATCH,
      url,
      params: params,
      header: commonHeader,
    );
  }

  Future<ApiModel> delete(
    String url, {
    Map<String, dynamic> params,
  }) async {
    return await agent.request(
      HttpVerb.DELETE,
      url,
      params: params,
      header: commonHeader,
    );
  }

  changeHostUrl(String url) {
    this.agent.changeHostUrl(url);
  }
}

final httpUtil = HttpUtil();
