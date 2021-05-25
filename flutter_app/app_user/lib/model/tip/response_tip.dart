import 'package:app_user/model/tip/tip_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_tip.g.dart';

@JsonSerializable()
class ResponseTip{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "data")
  TipVO data;
  @JsonKey(name: "msg")
  String msg;
  @JsonKey(name: "success")
  bool success;

  ResponseTip({this.code, this.data, this.msg, this.success});

  factory ResponseTip.fromJson(Map<String, dynamic> json) => _$ResponseTipFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseTipToJson(this);
}