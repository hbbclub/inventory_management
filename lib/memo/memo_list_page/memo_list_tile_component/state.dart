import 'package:fish_redux/fish_redux.dart';
import 'package:inventory_management/memo/memo_edit_page/memo_image_component/state.dart';
import 'package:json_annotation/json_annotation.dart';
part 'state.g.dart';

@JsonSerializable()
class MemoListTileState implements Cloneable<MemoListTileState> {
  @JsonKey(name: '_id')
  String id;
  String category;
  String notes;
  String keyword;
  @JsonKey(name: 'create_user_id')
  String createUserId;
  @JsonKey(name: 'create_user_group')
  String createUserGroup;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  int email;
  @JsonKey(toJson: _filesToJson, defaultValue: [])
  List<MemoImageState> files = [];

  factory MemoListTileState.fromJson(Map<String, dynamic> json) =>
      _$MemoListTileStateFromJson(json);

  Map<String, dynamic> toJson() => _$MemoListTileStateToJson(this);

  static List<Map<String, dynamic>> _filesToJson(List<MemoImageState> list) =>
      list.map<Map<String, dynamic>>((item) {
        return item.toJson();
      }).toList();

  MemoListTileState({
    this.id,
    this.notes,
    this.category,
    this.keyword,
    this.email,
    this.files,
    this.updatedAt,
  });

  @override
  MemoListTileState clone() {
    return MemoListTileState()
      ..id = id
      ..notes = notes
      ..category = category
      ..keyword = keyword
      ..email = email
      ..files = files
      ..updatedAt = updatedAt;
  }
}

MemoListTileState initState(Map<String, dynamic> args) {
  return MemoListTileState();
}
