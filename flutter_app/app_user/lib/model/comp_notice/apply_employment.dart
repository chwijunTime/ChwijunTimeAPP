import 'package:app_user/model/comp_notice/comp_notice_vo.dart';
import 'package:app_user/model/user/userinfo_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'apply_employment.g.dart';

@JsonSerializable()
class ApplyEmployment{
  @JsonKey(name: "applicationDate")
  String applyDate;
  @JsonKey(name: "applicationEmploymentIdx")
  int applyIdx;
  @JsonKey(name: "applicationEmploymentPortfolioURL")
  String portfolioUrl;
  @JsonKey(name: "applicationEmploymentResumeURL")
  String resumeUrl;
  @JsonKey(name: "applicationEmploymentStatus")
  String status;
  @JsonKey(name: "employmentAnnouncement")
  CompNoticeVO compNotice;
  @JsonKey(name: "gitHubURL")
  String githubUrl;
  @JsonKey(name: "member")
  UserInfoVO member;


  ApplyEmployment(
      {this.applyDate,
      this.applyIdx,
      this.portfolioUrl,
      this.resumeUrl,
      this.status,
      this.compNotice,
      this.githubUrl,
      this.member});

  factory ApplyEmployment.fromJson(Map<String, dynamic> json) => _$ApplyEmploymentFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyEmploymentToJson(this);
}