import 'package:app_user/model/user/profile_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_profile.g.dart';

@JsonSerializable()
class ResponseProfile {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: 'data')
  ProfileVO data;
  @JsonKey(name: 'msg')
  String msg;
  @JsonKey(name: 'success')
  bool success;


  ResponseProfile({this.code, this.data, this.msg, this.success});

  factory ResponseProfile.fromJson(Map<String, dynamic> json) => _$ResponseProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseProfileToJson(this);
}