import 'package:json_annotation/json_annotation.dart';

part 'correction_vo.g.dart';

@JsonSerializable()
class CorrectionVO{
  @JsonKey(name: "correctionApplyIdx")
  int index;
  @JsonKey(name: "correctionStatus")
  String status;
  @JsonKey(name: "correctionType")
  String type;
  @JsonKey(name: "memberClassNumber")
  String classNumber;
  @JsonKey(name: "memberEmail")
  String email;
  @JsonKey(name: "memberPortfolioIdx")
  int portfolioIdx;
  @JsonKey(name: "memberResumeIdx")
  int resumeIdx;
  @JsonKey(name: "notionPortfolioURL")
  String portfolioUrl;
  @JsonKey(name: "resumeFileURL")
  String resumeUrl;

  CorrectionVO(
      {this.index,
      this.status,
      this.type,
      this.classNumber,
      this.email,
      this.portfolioIdx,
      this.resumeIdx,
      this.portfolioUrl,
      this.resumeUrl});

  factory CorrectionVO.fromJson(Map<String, dynamic> json) => _$CorrectionVOFromJson(json);

  Map<String, dynamic> toJson() => _$CorrectionVOToJson(this);
}