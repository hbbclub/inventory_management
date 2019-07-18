import 'package:fish_redux/fish_redux.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:multi_image_picker/asset.dart';
part 'state.g.dart';

@JsonSerializable()
class MemoImageState implements Cloneable<MemoImageState> {
  @JsonKey(name: 'file_id')
  String id;
  String url;
  String src;
  @JsonKey(ignore: true)
  Asset asset;
  factory MemoImageState.fromJson(Map<String, dynamic> json) =>
      _$MemoImageStateFromJson(json);

  Map<String, dynamic> toJson() => _$MemoImageStateToJson(this);

  MemoImageState({this.id, this.url, this.src, this.asset});

  @override
  MemoImageState clone() {
    return MemoImageState()
      ..id = id
      ..src = src
      ..asset = asset
      ..url = url;
  }
}

MemoImageState initState(Map<String, dynamic> args) {
  return MemoImageState();
}
