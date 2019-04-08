import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'state.g.dart';

@JsonSerializable()
class StdState implements Cloneable<StdState> {
  String id = '';
  String cd = '';
  String name = '';
  String type = '';
  String paper = '';
  String size = '';
  String printer = '';
  String desc = '';
  List<Img> imgs = [];
  @JsonKey(ignore: true)
  TextEditingController textController = TextEditingController(text: '0');

  factory StdState.fromJson(Map<String, dynamic> json) =>
      _$StdStateFromJson(json);

  StdState({
    this.id,
    this.cd,
    this.name,
    this.type,
    this.paper,
    this.size,
    this.printer,
    this.desc,
    this.imgs,
  });

  @override
  StdState clone() {
    return StdState()
      ..id = id
      ..cd = cd
      ..name = name
      ..type = type
      ..paper = paper
      ..paper = paper
      ..size = size
      ..printer = printer
      ..desc = desc
      ..imgs = imgs
      ..textController = textController;
  }
}

StdState initState(Map<String, dynamic> args) {
  return StdState();
}

@JsonSerializable()
class Img {
  String url;

  Img({
    this.url,
  });

  factory Img.fromJson(Map<String, dynamic> json) => _$ImgFromJson(json);
}
