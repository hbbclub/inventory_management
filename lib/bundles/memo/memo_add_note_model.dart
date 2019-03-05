import 'package:json_annotation/json_annotation.dart';
part 'memo_add_note_model.g.dart';

@JsonSerializable()
class MemoAddNoteModel {
  @JsonKey(name: '_id')
  String id;
  String category;
  String notes;
  String keyword;
  int email;
  List<NodeItem> items;
  List<NodeFile> files;

  factory MemoAddNoteModel.fromJson(Map<String, dynamic> json) =>
      _$MemoAddNoteModelFromJson(json);

  Map<String, dynamic> tojson() => _$MemoAddNoteModelToJson(this);

  MemoAddNoteModel({
    this.id,
    this.notes,
    this.category,
    this.keyword,
    this.email,
    this.items,
    this.files,
  });
}

@JsonSerializable()
class NodeItem {
  String item;
  String value;

  factory NodeItem.fromJson(Map<String, dynamic> json) =>
      _$NodeItemFromJson(json);

  NodeItem({this.item, this.value});
}

@JsonSerializable()
class NodeFile {
  @JsonKey(name: '_id')
  String id;
  String url;
  factory NodeFile.fromJson(Map<String, dynamic> json) =>
      _$NodeFileFromJson(json);
  NodeFile({this.id, this.url});
}
