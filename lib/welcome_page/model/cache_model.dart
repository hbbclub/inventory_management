import 'dart:convert';

import 'package:inventory_management/login_page/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'cache_model.g.dart';

final String cacheKey = 'LOCAL_CACHE_KEY';

@JsonSerializable()
class CacheModel {
  @JsonKey(defaultValue: '')
  String account;
  @JsonKey(defaultValue: '')
  String password;
  @JsonKey(defaultValue: '')
  String linkword;
  @JsonKey(defaultValue: '')
  String hostUrl;
  @JsonKey(toJson: _userToJson)
  UserModel user = UserModel();

  CacheModel({
    this.account = '',
    this.password = '',
    this.linkword = '',
    this.hostUrl = '',
    this.user,
  });

  static Map<String, dynamic> _userToJson(UserModel user) => user.toJson();

  factory CacheModel.fromJson(Map<String, dynamic> json) =>
      _$CacheModelFromJson(json);

  Map<String, dynamic> toJson() => _$CacheModelToJson(this);

//读取缓存
  static Future<CacheModel> readLoaclCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rawJson = prefs.getString(cacheKey);
    if (rawJson == null) {
      return CacheModel();
    }
    return CacheModel.fromJson(json.decode(rawJson));
  }

  //设置缓存
  Future<bool> setLoaclCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(cacheKey, json.encode(this.toJson()));
  }
}

CacheModel cacheModel;
