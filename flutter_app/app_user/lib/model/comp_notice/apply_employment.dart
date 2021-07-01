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
  @JsonKey(name: "employmentAnnouncementAddress")
  String compAddress;
  @JsonKey(name: "employmentAnnouncementName")
  String compTitle;
  @JsonKey(name: "gitHubURL")
  String githubUrl;
  @JsonKey(name: "memberClassNumber")
  String classNumber;
  @JsonKey(name: "memberEmail")
  String email;
  @JsonKey(name: "recruitmentField")
  String field;


  ApplyEmployment(
      {this.applyDate,
      this.applyIdx,
      this.portfolioUrl,
      this.resumeUrl,
      this.status,
      this.compAddress,
      this.compTitle,
      this.githubUrl,
      this.classNumber,
      this.email,
      this.field});

  factory ApplyEmployment.fromJson(Map<String, dynamic> json) => _$ApplyEmploymentFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyEmploymentToJson(this);
}