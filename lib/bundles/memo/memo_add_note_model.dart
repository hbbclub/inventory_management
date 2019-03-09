import 'package:json_annotation/json_annotation.dart';
part 'memo_add_note_model.g.dart';

@JsonSerializable()
class MemoAddNoteModel {
  @JsonKey(name: '_id')
  String id;
  String category;
  String notes;
  String keyword;
  @JsonKey(name: 'updated_at')
  String updatedAt;
  int email;
  @JsonKey(toJson: _itemsToJson)
  List<NodeItem> items;
  @JsonKey(toJson: _filesToJson)
  List<NodeFile> files;

  factory MemoAddNoteModel.fromJson(Map<String, dynamic> json) =>
      _$MemoAddNoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemoAddNoteModelToJson(this);

  static List<Map<String, dynamic>> _itemsToJson(List<NodeItem> list) =>
      list.map<Map<String, dynamic>>((item) {
        return item.toJson();
      }).toList();

  static List<Map<String, dynamic>> _filesToJson(List<NodeFile> list) =>
      list.map<Map<String, dynamic>>((item) {
        return item.toJson();
      }).toList();

  MemoAddNoteModel({
    this.id,
    this.notes,
    this.category,
    this.keyword,
    this.email,
    this.items,
    this.files,
    this.updatedAt,
  });
}

@JsonSerializable()
class NodeItem {
  String item;
  String value;

  factory NodeItem.fromJson(Map<String, dynamic> json) =>
      _$NodeItemFromJson(json);

  Map<String, dynamic> toJson() => _$NodeItemToJson(this);

  NodeItem({this.item, this.value});
}

@JsonSerializable()
class NodeFile {
  @JsonKey(name: 'file_id')
  String id;
  String url;
  factory NodeFile.fromJson(Map<String, dynamic> json) =>
      _$NodeFileFromJson(json);

  Map<String, dynamic> toJson() => _$NodeFileToJson(this);

  NodeFile({this.id, this.url});
}
