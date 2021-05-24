import 'package:app_user/model/user/userinfo_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_vo.g.dart';

@JsonSerializable()
class ProfileVO{
  @JsonKey(name: "member")
  UserInfoVO member;
  @JsonKey(name: "memberTags")
  List<String> tag;

  ProfileVO({this.member, this.tag});

  factory ProfileVO.fromJson(Map<String, dynamic> json) => _$ProfileVOFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileVOToJson(this);
}