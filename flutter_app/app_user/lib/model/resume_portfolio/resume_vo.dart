import 'package:app_user/model/user/userinfo_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resume_vo.g.dart';

@JsonSerializable()
class ResumeVO {
  @JsonKey(name: "member")
  UserInfoVO member;
  @JsonKey(name: "memberResumeIdx")
  int index;
  @JsonKey(name: "notionResumeURL")
  String resumeUrl;

  String user;
  String state;


  ResumeVO(
      {this.member, this.index, this.resumeUrl, this.user, this.state});

  factory ResumeVO.fromJson(Map<String, dynamic> json) => _$ResumeVOFromJson(json);

  Map<String, dynamic> toJson() => _$ResumeVOToJson(this);
}