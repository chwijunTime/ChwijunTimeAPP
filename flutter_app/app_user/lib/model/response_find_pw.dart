import 'package:app_user/model/find_pw_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_find_pw.g.dart';

@JsonSerializable()
class ResponseFindPW{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "data")
  FindPWData data;
  @JsonKey(name: "msg")
  String msg;
  @JsonKey(name: "success")
  bool success;

  ResponseFindPW({this.code, this.data, this.msg, this.success});

  factory ResponseFindPW.fromJson(Map<String, dynamic> json) => _$ResponseFindPWFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseFindPWToJson(this);
}