import 'package:json_annotation/json_annotation.dart';

part 'api_model.g.dart';

enum ApiErrorDetail {
  httpError,
  logicError,
  noError,
}

@JsonSerializable()
class ApiModel {
  int error;
  Map<String, dynamic> data;
  String message;
  ApiModel();
  factory ApiModel.fromJson(Map<String, dynamic> json) =>
      _$ApiModelFromJson(json);

  bool isError() {
    return (this.error != 0) || (this.data['code'] != 0);
  }

  ApiErrorDetail get errDtaitl {
    if (this.error != 0) {
      return ApiErrorDetail.httpError;
    } else if ((this.data['code'] != 0)) {
      return ApiErrorDetail.logicError;
    }
    return ApiErrorDetail.noError;
  }

  String get errMsg {
    return this.data == null ? this.message : this.data['message'];
  }

  @override
  String toString() {
    return _$ApiModelToJson(this).toString();
  }
}
