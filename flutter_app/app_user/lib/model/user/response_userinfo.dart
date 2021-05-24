import 'package:app_user/model/user/userinfo_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_userinfo.g.dart';

@JsonSerializable()
class ResponseUserInfo{
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'data')
  UserInfoVO data;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;


  ResponseUserInfo({this.code, this.data, this.msg, this.success});

  factory ResponseUserInfo.fromJson(Map<String, dynamic> json) => _$ResponseUserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseUserInfoToJson(this);
}