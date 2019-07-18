
import 'package:json_annotation/json_annotation.dart';
part 'blue_tooth_model.g.dart';

@JsonSerializable()
class BlueToothModel{
  String name;
  String uuid;

  BlueToothModel({
    this.name,
    this.uuid,
  });

  factory BlueToothModel.fromJson(Map<String, dynamic> json) =>
      _$BlueToothModelFromJson(json);

}
