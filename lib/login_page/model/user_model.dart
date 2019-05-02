// Generated by https://quicktype.io
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String username;
  String name;
  @JsonKey(toJson: _companyToJson)
  Company company;
  @JsonKey(toJson: _categoriesToJson, defaultValue: [])
  Categories categories;
  @JsonKey(defaultValue: {})
  Initial initial;

  UserModel({
    this.username,
    this.name,
    this.company,
    this.categories,
    this.initial,
  });

  static Map<String, dynamic> _companyToJson(Company cmp) => cmp.toJson();
  static Map<String, dynamic> _categoriesToJson(Categories categories) =>
      categories.toJson();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class Company {
  String id;
  String name;

  Company({
    this.id,
    this.name,
  });
  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}

@JsonSerializable()
class Categories {
  List<String> write;

  Categories({
    this.write,
  });
  factory Categories.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesToJson(this);
}

@JsonSerializable()
class Initial {
  @JsonKey(name: 'TAG', defaultValue: 'T')
  String tag;
  @JsonKey(name: 'PART', defaultValue: 'P')
  String part;
  @JsonKey(name: 'LOC', defaultValue: 'C')
  String loc;
  @JsonKey(name: 'LOT', defaultValue: 'L')
  String lot;
  @JsonKey(name: 'QTY', defaultValue: 'Q')
  String qty;

  Initial({
    this.tag,
    this.part,
    this.loc,
    this.lot,
  });
  factory Initial.fromJson(Map<String, dynamic> json) =>
      _$InitialFromJson(json);

  Map<String, dynamic> toJson() => _$InitialToJson(this);
}
