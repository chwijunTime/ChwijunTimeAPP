import 'package:json_annotation/json_annotation.dart';

part 'corrected_vo.g.dart';

@JsonSerializable()
class CorrectedVO{
  @JsonKey(name: "classNumber")
  String classNumber;
  @JsonKey(name: "correctionApplyIdx")
  int applyIndex;
  @JsonKey(name: "correctionContent")
  String content;
  @JsonKey(name: "correctionIdx")
  int index;
  @JsonKey(name: "correctionStatus")
  String status;
  @JsonKey(name: "correctionType")
  String type;
  @JsonKey(name: "memberClassNumber")
  String memberClassNumber;
  @JsonKey(name: "memberEmail")
  String email;
  @JsonKey(name: "memberPortfolioIdx")
  int portfolioIdx;
  @JsonKey(name: "memberResumeIdx")
  int resumeIdx;
  @JsonKey(name: "notionPortfolioURL")
  String portfolioUrl;
  @JsonKey(name: "reasonForRejection")
  String rejectReason;
  @JsonKey(name: "resumeFileURL")
  String resumeUrl;


  CorrectedVO(
      {this.classNumber,
      this.applyIndex,
      this.content,
      this.index,
      this.status,
      this.type,
      this.memberClassNumber,
      this.email,
      this.portfolioIdx,
      this.resumeIdx,
      this.portfolioUrl,
      this.rejectReason,
      this.resumeUrl});

  factory CorrectedVO.fromJson(Map<String, dynamic> json) => _$CorrectedVOFromJson(json);

  Map<String, dynamic> toJson() => _$CorrectedVOToJson(this);
}