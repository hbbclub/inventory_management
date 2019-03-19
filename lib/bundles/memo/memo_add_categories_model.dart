// Generated by https://quicktype.io
import 'package:json_annotation/json_annotation.dart';
part 'memo_add_categories_model.g.dart';

@JsonSerializable()
class CategoriesModel {
  @JsonKey(name: '_id')
  String id;
  String category;
  String desc;
  String comment;

  CategoriesModel({
    this.id,
    this.category,
    this.desc,
    this.comment,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json);


}
