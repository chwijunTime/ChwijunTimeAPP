import 'package:app_user/model/correction/correction_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_correction.g.dart';

@JsonSerializable()
class ResponseCorrection{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'data')
  CorrectionVO data;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;

  ResponseCorrection({this.code, this.data, this.msg, this.success});

  factory ResponseCorrection.fromJson(Map<String, dynamic> json) => _$ResponseCorrectionFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseCorrectionToJson(this);
}