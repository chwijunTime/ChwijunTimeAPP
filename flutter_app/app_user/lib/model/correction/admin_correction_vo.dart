import 'package:app_user/model/resume_portfolio/portfolio_vo.dart';
import 'package:app_user/model/resume_portfolio/resume_vo.dart';
import 'package:app_user/model/user/userinfo_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'admin_correction_vo.g.dart';

@JsonSerializable()
class AdminCorrectionVO {
  @JsonKey(name: "correctionApplyIdx")
  int index;
  @JsonKey(name: "correctionStatus")
  String status;
  @JsonKey(name: "correctionType")
  String type;
  @JsonKey(name: "member")
  UserInfoVO member;
  @JsonKey(name: "memberPortfolio")
  PortfolioVO portfolio;
  @JsonKey(name: "memberResume")
  ResumeVO resume;

  AdminCorrectionVO(
      {this.index, this.status, this.type, this.member, this.portfolio, this.resume});

  factory AdminCorrectionVO.fromJson(Map<String, dynamic> json) =>
      _$AdminCorrectionVOFromJson(json);

  Map<String, dynamic> toJson() => _$AdminCorrectionVOToJson(this);
}
