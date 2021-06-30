import 'package:app_user/model/correction/admin_correction_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_admin_correction.g.dart';

@JsonSerializable()
class ResponseAdminCorrection{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'data')
  AdminCorrectionVO data;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;

  ResponseAdminCorrection({this.code, this.data, this.msg, this.success});

  factory ResponseAdminCorrection.fromJson(Map<String, dynamic> json) => _$ResponseAdminCorrectionFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseAdminCorrectionToJson(this);
}